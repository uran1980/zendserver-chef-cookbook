zendserver Cookbook
===================
**NOTE**: This cookbook installs Zend Server 6.1.0 with Apache / Nginx and PHP 5.3 / 5.4

**NOTE** I tested this cookbook only on Ubuntu Precise32 but it should work also on Debian (not tested).

**NOTE**: I'm planning to write tests and support CentOS, please contribute ;)

Usage in Vagrant
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


Todo
====
1. Don't use the install_zs.sh but write a full chef installation to allow configure of everything
2. Write kitchen tests
3. Support Debian and CentOS