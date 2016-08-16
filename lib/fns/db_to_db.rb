
def db_to_db(select_sql, table_name, columns)
  s = FluidDb::Db(ENV['SOURCE_DB']) if s.nil? # source
  d = FluidDb::Db(ENV['DEST_DB']) if d.nil? # destination

  insert_cmd = %{
    INSERT INTO #{table_name} (#{columns})
    VALUES (#{Array.new(columns.split(',').length, '?').join(',')})
  }

  rst = s.queryForResultset(select_sql)
  rst.each do |row|
    d.execute(insert_cmd, row.values)
  end

  DataPipe2.log "#{table_name}: #{rst.length}"
end
