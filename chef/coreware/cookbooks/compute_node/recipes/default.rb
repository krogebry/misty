#
# Cookbook Name:: compute_node
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "/tmp/blah" do
end

test = data_bag_item( "test","bag" )
test = data_bag( "test" )
