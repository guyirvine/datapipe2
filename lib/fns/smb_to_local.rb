require 'sambal'
require 'uri'
require 'cgi'

def smb_to_local(smb_uri_string, local_folder)
  # encode the string
  uri = URI.parse(URI.escape(smb_uri_string))
  domain = nil
  unless uri.query.nil?
    params = CGI.parse(uri.query)
    domain = params['domain'][0]
  end
  p "#{domain}, #{uri.host}, #{uri.user}, #{uri.password}"
  client = Sambal::Client.new(domain: domain, host: uri.host,
                              share: 'Data', user: uri.user, password: uri.password)
  client.ls(remote_dirpath).each do |remote_filepath|
    local_filepath = local_folder
    client.get(remote_filepath, local_filepath) # downloads file from server
    client.del(remote_filepath) # deletes files from server
  end
  client.close # closes connection
end
