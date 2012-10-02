topology 'ha'
server( 'frontend2.prod0.ksonsoftware.com', { :ipaddress => '10.2.87.221', :role => 'frontend' })
server( 'frontend1.prod0.ksonsoftware.com', { :ipaddress => '10.2.87.219', :role => 'frontend' })
server( 'frontend0.prod0.ksonsoftware.com', { :ipaddress => '10.2.87.218', :role => 'frontend' })
server( 'backend1.prod0.ksonsoftware.com', { :ipaddress => '10.2.87.217', :role => 'backend' })
server( 'backend0.prod0.ksonsoftware.com', { :ipaddress => '10.2.87.216', :role => 'backend' })
api_fqdn 'api.prod0.ksonsoftware.com'
backend_vip 'backend.prod0.ksonsoftware.com', { :device => 'eth0', :heartbeat_device => 'eth0' }
