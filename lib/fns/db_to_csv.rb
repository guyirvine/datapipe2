require 'csv'

def db_to_csv(sql, path, name)
  db_env_name = 'DB'
  db = DataPipe2.get_fluid_db(db_env_name)

  file_path = "#{path}/#{name}"
  File.delete(file_path) if File.exist?(file_path)

  rst = db.queryForResultset(sql, [])

  CSV.open(file_path, 'w') do |csv|
    csv << rst[0].keys
    rst.each { |r| csv << r.values }
  end
end
