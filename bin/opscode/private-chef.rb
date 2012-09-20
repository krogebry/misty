topology 'ha'
server( 'frontend2.prod0.ksonsoftware.com', { :ipaddress => '10.2.85.101', :role => 'frontend' })
server( 'frontend0.prod0.ksonsoftware.com', { :ipaddress => '10.2.85.99', :role => 'frontend' })
server( 'backend0.prod0.ksonsoftware.com', { :ipaddress => '10.2.85.100', :role => 'backend' })
server( 'frontend1.prod0.ksonsoftware.com', { :ipaddress => '10.2.85.98', :role => 'frontend' })
server( 'backend1.prod0.ksonsoftware.com', { :ipaddress => '10.2.85.97', :role => 'backend' })
api_fqdn 'api.prod0.ksonsoftware.com'
backend_vip 'backend.prod0.ksonsoftware.com', { :device => 'eth0', :heartbeat_device => 'eth0' }

