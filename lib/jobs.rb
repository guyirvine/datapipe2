# Doc
module DataPipe2
  require 'parse-cron'

  # Hold a single job definition
  class Job
    attr_reader :name, :next, :errorList

    def initialize(path)
      @path = path
      @name = File.basename(path, '.dsl')
      @cron_string = ''

      @error_list = []
      set_cron
    end

    # Job Error -> Time, Exception Class Name, nsg, backtrace
    def add_error(e)
      @error_list << "#{e.class.name}: #{e.message}\n#{e.backtrace.join("\n")}"
    end

    def clear_error
      @error_list = []
    end

    def run_now
      @next = Time.now - 1
    end

    def set_cron
      tmp = ENV["#{@name}_CRON"] ||= '0 0 * * *'
      return if tmp == @cron_string

      @cron_string = tmp
      @cron = CronParser.new(@cron_string)
    end

    def call
      run if Time.now > @next
    end

    def run
      begin
        DataPipe2.log "path: #{@path}", true
        DataPipe2.log "dsl: #{@name}"
        load @path
        clear_error
      rescue SystemExit, Interrupt
        raise
      rescue StandardError => e
        string = e.message
        p e.backtrace
        DataPipe2.log_dsl @name, string
        add_error(e)
      end

      set_cron
      @next = @cron.next(Time.now)
    end
  end

  # Hold all jobs
  class Jobs
    attr_reader :hash, :byName

    def initialize
      @hash = {}
      @by_name = {}
    end

    def call(path)
      if @hash[path].nil?
        j = Job.new(path)
        @hash[path] = j
        @by_name[j.name.downcase] = j
        j.run
      else
        @hash[path].call
      end
    end
  end
end
