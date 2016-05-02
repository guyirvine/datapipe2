require 'csv'

def csv_to_db(file_name, table_name)
  db_env_name = 'DB'
  db = DataPipe2.get_fluid_db(db_env_name)
  db.execute("TRUNCATE TABLE #{table_name}", [])

  csv = CSV.read(file_name)
  columns = csv.shift
  sql = "INSERT INTO #{table_name} ( #{columns.join(',')} )
          VALUES (#{Array.new(columns.length, '?').join(',')})"
  csv.each do |row|
    db.execute(sql, row)
  end
  DataPipe2.log "#{table_name}: #{csv.length}", true
end
