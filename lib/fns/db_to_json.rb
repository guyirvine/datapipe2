require 'FluidDb'
require 'json'

def db_to_json(sql, path, name)
  # Dir.mkdir(path) unless Dir.exists?(path)
  db_env_name = 'DB'
  db = DataPipe2.get_fluid_db(db_env_name)

  file_path = "#{path}/#{name}"
  File.delete(file_path) if File.exist?(file_path)

  rst = db.queryForResultset(sql, [])
  File.write(file_path, rst.to_json)
end
