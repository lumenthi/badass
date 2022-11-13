vtysh
conf t
hostname <router_name>
no ipv6 forwarding
!
interface eth0
  ip address <eth0 router-1>/30
!
interface eth1
  ip address <eth1 router-1>/30
!
interface eth2
  ip address <eth2 router-1>/30
!
interface lo
  ip address <lo router-1>/32
!
router bgp 1
  neighbor ibgp peer-group
  neighbor ibgp remote-as 1
  neighbor ibgp update-source lo
  bgp listen range 1.1.1.0/29 peer-group ibgp
  !
  address-family l2vpn evpn
    neighbor ibgp activate
    neighbor ibgp route-reflector-client
  exit-address-family
!
router ospf
  network 0.0.0.0/0 area 0
!
line vty
