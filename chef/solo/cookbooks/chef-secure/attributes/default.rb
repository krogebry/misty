#
# Author:: Bryan Kroger ( bryan.kroger@gmail.com )
# Cookbook Name:: chef-secure
# Attributes:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

case platform
when "arch"
  default["chef_secure"]["init_style"]  = "arch"
  default["chef_secure"]["path"]        = "/var/lib/chef_secure"
  default["chef_secure"]["run_path"]    = "/var/run/chef_secure"
  default["chef_secure"]["cache_path"]  = "/var/cache/chef_secure"
  default["chef_secure"]["backup_path"] = "/var/lib/chef_secure/backup"
when "debian","ubuntu","redhat","centos","fedora"
  default["chef_secure"]["init_style"]  = "init"
  default["chef_secure"]["path"]        = "/var/lib/chef_secure"
  default["chef_secure"]["run_path"]    = "/var/run/chef_secure"
  default["chef_secure"]["cache_path"]  = "/var/cache/chef_secure"
  default["chef_secure"]["backup_path"] = "/var/lib/chef_secure/backup"
when "openbsd","freebsd","mac_os_x"
  default["chef_secure"]["init_style"]  = "bsd"
  default["chef_secure"]["path"]        = "/var/chef_secure"
  default["chef_secure"]["run_path"]    = "/var/run"
  default["chef_secure"]["cache_path"]  = "/var/chef_secure/cache"
  default["chef_secure"]["backup_path"] = "/var/chef_secure/backup"
else
  default["chef_secure"]["init_style"]  = "none"
  default["chef_secure"]["path"]        = "/var/chef_secure"
  default["chef_secure"]["run_path"]    = "/var/run"
  default["chef_secure"]["cache_path"]  = "/var/chef_secure/cache"
  default["chef_secure"]["backup_path"] = "/var/chef_secure/backup"
end

default['chef_secure']['umask']           = "0022"
default['chef_secure']['url']             = "http://localhost:4020"
default['chef_secure']['log_dir']         = "/var/log/chef_secure"
default['chef_secure']['api_port']        = "4020"
default['chef_secure']['webui_port']      = "4060"
default['chef_secure']['webui_enabled']   = false
