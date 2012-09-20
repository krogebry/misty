topology "ha"

server "fe1.example.com",
 :ipaddress => "192.168.4.2",
 :role => "frontend"
server "fe2.example.com",
 :ipaddress => "192.168.4.3",
 :role => "frontend"
server "fe3.example.com",
 :ipaddress => "192.168.4.4",
 :role => "frontend"

server "be1.example.com"
 :ipaddress => "192.168.4.1",
 :role => "backend",
 :bootstrap => true,
 :cluster_ipaddress => "10.1.2.10"

server "be2.example.com",
 :ipaddress => "192.168.4.6",
 :role => "backend",
 :cluster_ipaddress => "10.1.2.12"


backend_vip "be.example.com",
 :ipaddress => "192.168.4.7",
 :device => "eth0",
 :heartbeat_device => "eth1"

api_fqdn "chef.example.com"
