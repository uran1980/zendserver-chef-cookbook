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
php = node[:zendserver][:phpversion]
path = 'PATH=$PATH:/usr/local/zend/bin'
ld_library = 'LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/zend/lib'
version = nil
if ws == 'apache'
  version = "#{:php} --automatic"
elsif php == 'nginx'
  version = "#{:php} nginx --automatic"
end

execute 'extract' do
  command 'tar -xvf /tmp/zs.tar'
  creates '/tmp/ZendServer-RepositoryInstaller-linux'
  action :run
end

execute 'install' do
  command "sh /tmp/ZendServer-RepositoryInstaller-linux/install_zs.sh #{version}"
  creates '/usr/local/zend'
  action :run
end

execute 'update_zsh_path' do
  command "echo '#{path}' >> /etc/profile"
  action :run
end

execute 'update_zsh_ld_library' do
  command "echo '#{ld_library}' >> /home/vagrant/.zshrc"
  action :run
end