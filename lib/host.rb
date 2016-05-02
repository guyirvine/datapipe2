require 'rubygems'
require 'rack'
require 'thin'

module DataPipe2
  # Host
  class Host
    def run
      libs = ENV['LIB'] ||= './lib'
      libs.split(';').each do |path|
        DataPipe2.log "Adding libdir: #{path}"
        $LOAD_PATH.unshift path
      end

      @dsl_paths = ENV['DSL'] ||= './dsl'
      DataPipe2.log "dsl_paths: #{@dsl_paths}"
      @hash = {}

      @hash['jobs'] = Jobs.new
      long_run
    end

    def long_run
      Kernel.loop do
        begin
          single_run

          sleep 0.5
        rescue SystemExit, Interrupt
          puts 'Exiting on request ...'
          break
        end
      end
    end

    def single_run
      @dsl_paths.split(';').each do |dsl_dir|
        Dir.glob("#{dsl_dir}/*.dsl").each do |dsl_path|
          @hash['jobs'].call dsl_path
        end
      end
    end
  end
end
