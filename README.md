local-dev
=========

Ansible playbooks and vagrant config for local dev environment.

### Dependencies

* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](http://www.vagrantup.com/)

### Getting started

You can build the virtual machine as follows:

```shell
cd local-dev/vagrant
vagrant up
```

If you're going to be doing on-server development you'll want to add your public
key to the authorized_hosts file on the VM:

```shell
vagrant ssh
# This is an example of fetching authorized keys, it's up to you to
# figure out how to get your public key on the VM...
wget http://fourkitchens.com/authorized_keys -O /tmp/authorized_keys
cat /tmp/authorized_keys >> ~/.ssh/authorized_keys
exit
```

then uncomment the following line in ```local-dev/vagrant/VagrantFile```

```
config.ssh.private_key_path = "~/.ssh/id_rsa"
```

and reboot the VM with:

```shell
vagrant halt && vagrant up
```

### Magic hosts!

Any directories in ```local-dev/hosts``` will automatically be made available with
nginx. For example:

```shell
mkdir local-dev/hosts/test
echo 'boom' > local-dev/hosts/test/index.html
```

Will set up a site that can be accessed at ```http://test.local:8888``` (or
```http://test.local:8000``` to bypass varnish) after you add the following
to your ```/etc/hosts``` file:

```
127.0.0.1 test.local
```

### Drush aliases

Any ```php``` files in the ```local-dev/vagrant/provision/files/drush``` directory
will be copied to ```~/.drush/``` during provisioning, providing an easy way to move
drush alias files around.

### Local port forwards

If you'd like to be able to access sites on port 80 and 443 rather than 8888 and 8443
respectively (and you're on a mac) run the following commands:

```shell
sudo ipfw add 100 fwd 127.0.0.1,8888 tcp from any to me 80
sudo ipfw add 101 fwd 127.0.0.1,8443 tcp from any to me 443
```

For a more detailed guide on port forwarding (and info on making this change permanent)
see [this post](http://www.dmuth.org/node/1404/web-development-port-80-and-443-vagrant).

### Remote debugging

xdebug is enabled but remote autostart is not. You can either flip this setting in
/etc/php5/conf.d/xdebug.ini or you can use a browser extension like [XDebug helper](https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc)
to enable/disable debugging on the fly.

[MacGDBp](http://www.bluestatic.org/software/macgdbp/) is a simple remote debugger
for OSX. It's a little flakey but will work in most instances.

### Git

If you'll be committing code in git on the VM you'll want to change the ```git_name``` and ```git_mail```
variables in ```vagrant/provision/settings.yml```.

