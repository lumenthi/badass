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
router bgp 1                                       # Configure BGP instance 1
  neighbor ibgp peer-group                         # Create a BGP peer group
  neighbor ibgp remote-as 1                        # Update the BGP neighbor table and assign AS n1 to ibgp group
  neighbor ibgp update-source lo                   # Specify the source address to reach the neighbor (1.1.1.1)
  bgp listen range <lo range> peer-group ibgp      # Choose an effective range for ibgp grp 1.1.1.0/29 = 1.1.1.1 - 1.1.1.6

  address-family l2vpn evpn                        # Create the BGP EVPN address family and enter its view
    neighbor ibgp activate                         # Activate BGP neighbors under the L2VPN address family
    neighbor ibgp route-reflector-client           # Configures the router as a BGP route reflector for ibgp group
    exit-address-family                            # Leave BGP EVPN view

router ospf                                        # Access ospf configuration
  network 0.0.0.0/0 area 0                         # Enable OSPF in every interface for that area (backbone area)

# =LEAFS routers=

# (shell config) Bridge configuration
brctl addbr br0                                    # Create bridge
ip link set up dev br0                             # Activate bridge
ip link add vxlan10 type vxlan id 10 dstport 4789  # Create VxLAN interface
ip link set up dev vxlan10                         # Activate VxLAN interface
brctl addif br0 vxlan10                            # Add VxLAN to bridge
brctl addif br0 eth1                               # Add eth1 to bridge

# (vtysh config) Enable conf mode
conf t

# Interfaces configuration
# No need to configure eth1 interface since it can't be reached and is mixed with br0
interface eth0
  ip address <eth0 current router>
  ip ospf area 0                                   # Specify the eht0 interface to participate in the OSPF routing process for the backbone area
interface lo
  ip address <lo current router>
  ip ospf area 0                                   # Specify the lo interface to participate in the OSPF routing process for the backbone area

# BGP configuration
router bgp 1                                       # Configure BGP instance 1
# Neighbor declaration (RR router)
  neighbor <lo router_lumenthi-1> remote-as 1      # Update the BGP neighbor table, assign RR lo address to AS n1
  neighbor <lo router_lumenthi-1> update-source lo # Specify the source address to reach the neighbor (RR lo address)

  address-family l2vpn evpn                        # Create the BGP EVPN address family and enter its view
    neighbor 1.1.1.1 activate                      # Activate the RR router neighbor under the L2VPN address family
    advertise-all-vni                              # Make changes effective
    exit-address-family                            # Leave BGP EVPN view

router ospf                                        # Activate the OSPF service

# ==SOURCES==
https://www.youtube.com/watch?v=Ek7kFDwUJBM
https://www.arubanetworks.com/techdocs/AOS-CX/10.10/HTML/ip_route_6300-6400-83xx-9300-10000/Content/Chp_BGP/BGP_cmds/nei-rem-as-10.htm
