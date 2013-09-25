zendserver Cookbook
===================
**NOTE**: This cookbook installs Zend Server 6.1.0 with Apache / Nginx and PHP 5.3 / 5.4
**NOTE** I tested this cookbook only on Ubuntu Precise32 but it should work also on Debian (not tested).
**Note**: I'm planning to write tests and support CentOS, please contribute ;)

Usage on Vagrant
================

```ruby
     config.vm.provision 'chef_solo' do |chef|
       chef.cookbooks_path = ['cookbooks']
       chef.add_recipe 'zendserver'
       chef.json = {
           :zendserver => {
               :webserver => 'nginx',
               :phpversion => 5.4
           }
       }
     end
```