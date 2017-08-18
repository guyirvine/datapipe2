
def db_to_pgsql(select_sql, table_name, columns)
  s = FluidDb::Db(ENV['SOURCE_DB']) # source
  d = FluidDb::Db(ENV['PGSQL']) # destination

  d.connection.exec("TRUNCATE TABLE #{table_name}")
  copy_cmd = %{
    COPY #{table_name} (#{columns})
    FROM STDIN
    WITH DELIMITER AS '|'
    CSV;
  }
  d.connection.exec(copy_cmd)

  results = s.connection.execute(select_sql)

  count = 0
  results.each(as: :array, cache_rows: false) do |r|
    count += 1
    print '.' if count % 100_000 == 0
    d.connection.put_copy_data "#{r.join('|')}\n"
  end
  puts ""
  d.connection.put_copy_end

  DataPipe2.log "#{table_name}: #{count}"
end
