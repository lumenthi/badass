brctl addbr br0
ip link set up dev br0
ip link add vxlan10 type vxlan id 10 dstport 4789
ip link set up dev vxlan10
brctl addif br0 vxlan10
brctl addif br0 eth1

vtysh
conf t
hostname <router_name>
no ipv6 forwarding
!
interface eth0
  ip address <eth0 router-2>/30
  ip ospf area 0
!
interface lo
  ip address <lo router-2>/32
  ip ospf area 0
router bgp 1
  neighbor <lo router-1> remote-as 1
  neighbor <lo router-1> update-source lo
  !
  address-family l2vpn evpn
   neighbor <lo router-1> activate
   advertise-all-vni
  exit-address-family
!
router ospf
