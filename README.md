zendserver Cookbook
===================
1. This cookbook installs Zend Server 6.1.0 with Apache / Nginx and PHP 5.3 / 5.4;
2. I tested this cookbook only on Ubuntu Precise32 but it should work also on Debian (not tested);
3. I'm planning to write tests and support CentOS;

Attributes
==========

 - `:webserver`:  Available options: apache, nginx
 - `:php_version`: Available options: 5.3, 5.4

```ruby
default[:zendserver][:webserver] = "nginx" # or apache
default[:zendserver][:php_version] = 5.4 # or 5.3
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
            :php_version => 5.4
        }
  }
end
```

chef-solo Example
=================

Fetch the cookbook
------------------
Add this cookbook to the configured cookbooks path in the solo.rb
(you can use the following command to clone in the chef-solo cookbooks directory - requires GIT)

```bash
   mkdir -p /var/chef-solo/cookbooks && git clone https://github.com/fontanalorenzo/zendserver-chef-cookbook /var/chef-solo/cookbooks/zendserver-chef-cookbook
```

solo.rb
-------
If you haven't already done yet, create a `solo.rb` file.
```ruby
file_cache_path "/var/chef-solo"
cookbook_path "/var/chef-solo/cookbooks"
```

node.json
---------
Create the `node.json` file with the following content or update your existing one
configuring the zendserver cookbook.
- The webserver config could also be set to nginx,
- The php_version config could also be set to 5.3

```json
{
  "zendserver": {
    "webserver": "apache",
    "php_version": 5.4
  },
  "run_list": [ "recipe[zendserver-chef-cookbook]" ]
}
```

Run!
----
```bash
chef-solo -c ~/solo.rb -j ~/node.json
```

Bugs
====
If you find any bugs, please report me **fontanalorenzo@me.com**

Contribute
=========
It would be a pleasure if you can contribute to this cookbook ;)
To contribute, just fork and send your pull request.
Currently, working on the master branch tagging any definitive version, so please refer to the master branch.

Todo
====
See the [Issues](https://github.com/fontanalorenzo/zendserver-chef-cookbook/issues)
