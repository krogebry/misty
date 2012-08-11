##
# Solo file.
FS_ROOT = File.dirname( __FILE__ )

log_level :debug
log_location STDOUT
cache_type "BasicFile"
cache_options({ :path => "%s/.chef/checksums" % ENV['HOME'], :skip_expires => true })
file_cache_path "%s/.chef/cache/" % ENV['HOME']
file_backup_path "%s/.chef/cache/" % ENV['HOME']
#cookbook_path "~/var/chef-solo/cookbooks"
role_path "%s/roles" % FS_ROOT
cookbook_path "%s/cookbooks" % FS_ROOT
#cookbook_path "/home/krogebry/Dropbox/Private/Krogebry/chef/cookbooks"
#role_path "/home/krogebry/Dropbox/Private/Krogebry/chef/roles"


