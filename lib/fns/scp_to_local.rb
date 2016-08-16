require 'net/sftp'
require 'fileutils'
require 'uri'

def scp_to_local(scp_uri_string,
                 remote_done_path,
                 local_path,
                 local_working_path = nil)
  scp_uri = URI.parse(scp_uri_string)
  remote_ready_path = "#{scp_uri.path}"

  local_working_path = "/tmp/#{local_path}" if local_working_path.nil?
  FileUtils.mkdir_p local_working_path
  # Check we can write to local path

  Net::SFTP.start(scp_uri.host, scp_uri.user) do |sftp|
    # Check we can read and write from remote_ready_path
    # Check we can write to remote_done_path
    # puts "remote_ready_path: #{sftp.lstat!('remote_ready_path').permissions}"
    # puts "remote_done_path: #{sftp.lstat!('remote_done_path').permissions}"
    sftp.dir.foreach(remote_ready_path) do |entry|
      if entry.file?
        puts entry.name
        sftp.download!(
          "#{remote_ready_path}/#{entry.name}",
          "#{local_working_path}/#{entry.name}")

        FileUtils.mv("#{local_working_path}/#{entry.name}", local_path)

        sftp.rename!("#{remote_ready_path}/#{entry.name}",
                     "#{remote_done_path}/#{entry.name}")
      end
    end
  end

  FileUtils.rm_rf local_working_path
end
