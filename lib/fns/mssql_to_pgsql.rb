
def mssql_to_pgsql(mssql, pgsql, select_sql, tableName, columns)
  s = FluidDb::Db(ENV[mssql]) # source
  d = FluidDb::Db(ENV[pgsql]) # destination

  d.connection.exec("TRUNCATE TABLE #{tableName}")
  copy_cmd = %{
    COPY #{tableName} (#{columns.join(',')})
    FROM STDIN
    WITH DELIMITER AS '|'
    CSV;"
  }
  d.connection.exec(copy_cmd)

  results = s.connection.execute(select_sql)

  count = 0
  results.each(as: array, cache_rows: false) do |r|
    count += 1
    d.connection.put_copy_data "#{r.join('|')}\n"
  end
  d.connection.put_copy_end

  DataPipe2.log "#{tableName}: #{count}"
end
