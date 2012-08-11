#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
directory "%s/.tmp" % ENV['HOME'] do
	owner ENV['SUDO_USER']
	group ENV['SUDO_USER']
	action :create
	recursive true
end

directory "%s/.chef" % ENV['HOME'] do
	owner ENV['SUDO_USER']
	group ENV['SUDO_USER']
	action :create
	recursive true
end

["admin","validation","admin"].each do |file_name|
	cookbook_file "%s/.chef/%s.pem" % [ENV['HOME'],file_name] do
		owner ENV['SUDO_USER']
		group ENV['SUDO_USER']
		source "%s.pem" % file_name
	end
end

cookbook_file "%s/.vimrc" % ENV['HOME'] do
	owner ENV['SUDO_USER']
	group ENV['SUDO_USER']
	source "vimrc"
end

cookbook_file "%s/.bashrc" % ENV['HOME'] do
	owner ENV['SUDO_USER']
	group ENV['SUDO_USER']
	source "bashrc"
end

