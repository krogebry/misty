##
# Simple snmpd setup
#

package "snmp"
package "snmpd"

cookbook_file "/etc/snmp/snmpd.conf" do
  mode "0600"
  owner "root"
  group "root"
  source "snmpd.conf"
end
