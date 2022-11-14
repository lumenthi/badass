vtysh
conf t
hostname router_lumenthi-1
no ipv6 forwarding
!
interface eth0
  ip address 36.112.17.2/30
!
interface eth1
  ip address 36.112.17.4/30
!
interface eth2
  ip address 36.112.17.6/30
!
interface lo
  ip address 1.1.1.1/32
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
