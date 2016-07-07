
def db_to_db(select_sql, table_name, columns)
  ENV['s'] = FluidDb::Db(ENV['SOURCE_DB']) if ENV['s'].nil? # source
  ENV['d'] = FluidDb::Db(ENV['DEST_DB']) if ENV['d'] # destination

  insert_cmd = %{
    INSERT INTO #{table_name} (#{columns})
    VALUES (#{Array.new(columns.split(',').length, '?').join(',')})
  }

  rst = ENV['s'].queryForResultset(select_sql)
  rst.each do |row|
    ENV['d'].execute(insert_cmd, row.values)
  end

  DataPipe2.log "#{table_name}: #{rst.length}"
end
