# Don't buffer stdout
$stdout.sync = true

# Don't buffer stdout
module DataPipe2
  require 'helper_functions'
  require 'jobs'
  require 'host'

  require 'fns/db_to_csv'
  require 'fns/db_to_json'
  require 'fns/csv_to_db'
  require 'fns/mssql_to_pgsql'
  require 'fns/smb_to_local'
  require 'fns/scp_to_local'
  require 'fns/db_to_db'

  class DataPipe2lineError < StandardError
  end
  class EnvironmentVariableNotFoundError < DataPipe2lineError
  end
end
