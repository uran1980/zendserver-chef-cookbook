#
# Cookbook Name:: zendserver
# Recipe:: default
#

cookbook_file 'ZendServer-6.1.0-RepositoryInstaller-linux.tar' do
  backup false
  path '/tmp/zs.tar'
  action :create_if_missing
end

ws = node[:zendserver][:webserver]
php = node[:zendserver][:php_version]
path = 'PATH=$PATH:/usr/local/zend/bin'
ld_library = 'LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/zend/lib'
version = ""
if ws == 'apache'
  version = "#{php} --automatic"
elsif ws == 'nginx'
  version = "#{php} nginx --automatic"
end

execute 'extract' do
  command 'tar -xvf /tmp/zs.tar'
  action :run
end

execute 'install' do
  command "sh /tmp/ZendServer-RepositoryInstaller-linux/install_zs.sh #{version}"
  creates '/usr/local/zend'
  action :run
end

execute 'update_etc_profile' do
  command "echo '#{path}' >> /etc/profile && echo '#{ld_library}' >> /etc/profile"
  action :run
end

users = node[:zendserver][:users]

if users.count > 0
  for user in users
    user_path = "/home/#{user}/"
    if File.exist?("#{user_path}.bashrc")
      execute 'update_bashrc' do
        command "echo '#{path}' >> #{user_path}.bashrc && echo '#{ld_library}' >> #{user_path}.bashrc"
        action :run
      end
    end
    if File.exist?("#{user_path}.zshrc")
      execute 'update_zshrc' do
        command "echo '#{path}' >> #{user_path}.zshrc && echo '#{ld_library}' >> #{user_path}.zshrc"
        action :run
      end
    end
  end
end
