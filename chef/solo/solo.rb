##
# Solo file.
FS_ROOT = File.expand_path(File.dirname( __FILE__ ))

log_level :debug
log_location STDOUT
cache_type "BasicFile"
cache_options({ :path => "%s/.chef/checksums" % ENV['HOME'], :skip_expires => true })
file_cache_path "%s/.chef/cache/" % ENV['HOME']
file_backup_path "%s/.chef/cache/" % ENV['HOME']
role_path "%s/roles" % FS_ROOT
cookbook_path "%s/cookbooks" % FS_ROOT
