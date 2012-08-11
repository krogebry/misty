maintainer        "Bryan Kroger"
maintainer_email  "bryan.kroger@gmail.com"
license           "Apache 2.0"
description       "Installs and configures Chef Secure"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"
recipe            "chef-secure", "Chef Secure"

#%w{ ubuntu debian redhat centos fedora freebsd openbsd }.each do |os|
  #supports os
#end

#%w{ runit bluepill daemontools couchdb apache2 nginx openssl zlib xml java gecode }.each do |cb|
  #depends cb
#end
