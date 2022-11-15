# ===IPs configuration===

+-------------------+-------------+-----------------+------------------------+
| HOST              |  INTERFACE  |  IP             | LINK                   |
+-------------------+-------------+-----------------+------------------------+
|                                 Hosts                                      |
+-------------------+-------------+-----------------+------------------------+
| host_lumenthi-1   |   eth0      | 56.112.17.2/24  | router_lumenthi-2/eth1 |
+-------------------+-------------+-----------------+------------------------+
| host_lumenthi-2   |   eth0      | 56.112.17.3/24  | router_lumenthi-3/eth1 |
+-------------------+-------------+-----------------+------------------------+
| host_lumenthi-3   |   eth0      | 56.112.17.4/24  | router_lumenthi-4/eth1 |
+-------------------+-------------+-----------------+------------------------+
|                                 RR Router                                  |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-1 |   lo        | 1.1.1.1/32      | none                   |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-1 |   eth0      | 36.112.17.1/30  | router_lumenthi-2/eth0 |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-1 |   eth1      | 36.112.17.5/30  | router_lumenthi-3/eth0 |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-1 |   eth2      | 36.112.17.9/30  | router_lumenthi-4/eth0 |
+-------------------+-------------+-----------------+------------------------+
|                                 Leafs Routers                              |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-2 |   lo        | 1.1.1.2/32      | none                   |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-2 |   eth0      | 36.112.17.2/30  | router_lumenthi-1/eth0 |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-2 |   eth1      | xx.xxx.xx.x/xx  | host_lumenthi-1/eth0   |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-3 |   lo        | 1.1.1.3/32      | none                   |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-3 |   eth0      | 36.112.17.6/30  | router_lumenthi-1/eth0 |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-3 |   eth1      | xx.xxx.xx.x/xx  | host_lumenthi-2/eth0   |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-4 |   lo        | 1.1.1.4/32      | none                   |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-4 |   eth0      | 36.112.17.10/30 | router_lumenthi-1/eth0 |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-4 |   eth1      | xx.xxx.xx.x/xx  | host_lumenthi-3/eth0   |
+-------------------+-------------+-----------------+------------------------+

# ==CONFIGS==

# =RR router=

# (vtysh config) Enable conf mode
conf t

# Interfaces configuration
interface eth0
  ip address <eth0 router_lumenthi-1>
interface eth1
  ip address <eth1 router_lumenthi-1>
interface eth2
  ip address <eth2 router_lumenthi-1>
interface lo
  ip address <lo router_lumenthi-1>

# BGP configuration
router bgp 1
  neighbor ibgp peer-group
  neighbor ibgp remote-as 1
  neighbor ibgp update-source lo
  bgp listen range <lo range> peer-group ibgp # 1.1.1.0/29 = 1.1.1.1 - 1.1.1.6

  address-family l2vpn evpn
    neighbor ibgp activate
    neighbor ibgp route-reflector-client
    exit-address-family

router ospf
  network 0.0.0.0/0 area 0

# =LEAFS routers=

# (shell config) Bridge configuration
brctl addbr br0
ip link set up dev br0
ip link add vxlan10 type vxlan id 10 dstport 4789
ip link set up dev vxlan10
brctl addif br0 vxlan10
brctl addif br0 eth1

# (vtysh config) Enable conf mode
conf t

# Interfaces configuration
# No need to configure eth1 interface since it can't be reached and is mixed with br0
interface eth0
  ip address <eth0 current router>
  ip ospf area 0
interface lo
  ip address <lo current router>
  ip ospf area 0

# BGP configuration
router bgp 1
# Neighbor declaration (RR router)
  neighbor <lo router_lumenthi-1> remote-as 1
  neighbor <lo router_lumenthi-1> update-source lo

  address-family l2vpn evpn
    neighbor 1.1.1.1 activate
    advertise-all-vni
    exit-address-family

router ospf

# ==TODO==
- Steps description
