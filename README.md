zendserver Cookbook
===================
**NOTE**: This cookbook installs Zend Server 6.1.0 with Apache / Nginx and PHP 5.3 / 5.4

**NOTE** I tested this cookbook only on Ubuntu Precise32 but it should work also on Debian (not tested).

**NOTE**: I'm planning to write tests and support CentOS, please contribute ;)

Attributes
==========

 - `:webserver`: The webserver to install (Apache or Nginx)
 - `:php_version`: The PHP version to install 5.3 or 5.3
 - `:users`: Users who update .bashrc / .zshrc

```ruby
default[:zendserver][:webserver] = "nginx"
default[:zendserver][:php_version] = 5.4
default[:zendserver][:users] = ['vagrant']
```

Vagrant Example
================

```ruby
config.vm.provision 'chef_solo' do |chef|
  chef.cookbooks_path = ['cookbooks']
  chef.add_recipe 'zendserver'
  chef.json = {
        :zendserver => {
            :webserver => 'nginx',
            :php_version => 5.4,
            :users => ['vagrant']
        }
  }
end
```

chef-solo Example
=================
solo.rb
-------
- Create the `solo.rb` file
```ruby
file_cache_path "/var/chef-solo"
cookbook_path "/var/chef-solo/cookbooks"
```

- Add this cookbook to the configured cookbooks path in the solo.rb
( you can use the following command to clone in the chef-solo cookbooks directory)

```bash
   git clone https://github.com/fontanalorenzo/zendserver-chef-cookbook /var/chef-solo/cookbooks/zendserver-chef-cookbook
```

- Crete the `node.json` file with the following content
(you can omit users, and configure webserver also to nginx and php_version to 5.3)
```json
{
  "zendserver": {
    "webserver": "apache",
    "php_version": 5.4,
    "users": ["renzo"]
  },
  "run_list": [ "recipe[zendserver-chef-cookbook]" ]
}
```

Todo
====
1. Don't use the install_zs.sh but write a full chef installation to allow configure of everything
2. Write kitchen tests
3. Support Debian and CentOS
