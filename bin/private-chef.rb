topology 'ha'
server( 'frontend2.prod0.ksonsoftware.com', { :ipaddress => '10.2.86.209', :role => 'frontend' })
server( 'frontend1.prod0.ksonsoftware.com', { :ipaddress => '10.2.86.207', :role => 'frontend' })
server( 'frontend0.prod0.ksonsoftware.com', { :ipaddress => '10.2.86.198', :role => 'frontend' })
server( 'backend1.prod0.ksonsoftware.com', { :ipaddress => '10.2.86.206', :role => 'backend' })
server( 'backend0.prod0.ksonsoftware.com', { :ipaddress => '10.2.86.205', :bootstrap => true, :role => 'backend' })
api_fqdn 'api.prod0.ksonsoftware.com'
backend_vip 'backend.prod0.ksonsoftware.com', { :device => 'eth0', :heartbeat_device => 'eth0' }
