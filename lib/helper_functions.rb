require 'FluidDb'

# DataPipe2 Helpers
module DataPipe2
  def self.log(string, verbose = false)
    type = verbose ? 'VERB' : 'INFO'
    if !ENV['VERBOSE'].nil? || !verbose
      timestamp = Time.new.strftime('%Y-%m-%d %H:%M:%S')
      puts "[#{type}] #{timestamp} :: #{string}"
    end
  end

  def self.log_dsl(name, string, verbose = false)
    log "name: #{name}, #{string}", verbose
  end

  def self.get_env_var(name)
    fail EnvironmentVariableNotFoundError, name if ENV[name].nil?
    ENV[name]
  end

  def self.get_fluid_db(env_name)
    uri_string = get_env_var(env_name)
    log "uri: #{uri_string}", true
    FluidDb::Db(uri_string)
  end
end
