# ===IPs configuration===

+-------------------+-------------+-----------------+------------------------+
| HOST              |  INTERFACE  |  IP             | LINK                   |
+-------------------+-------------+-----------------+------------------------+
|                                 Hosts                                      |
+-------------------+-------------+-----------------+------------------------+
| host_lumenthi-1   |   eth0      |  56.112.17.6/24 | router_lumenthi-2/eth1 |
+-------------------+-------------+-----------------+------------------------+
| host_lumenthi-2   |   eth0      |  56.112.17.7/24 | router_lumenthi-3/eth1 |
+-------------------+-------------+-----------------+------------------------+
| host_lumenthi-3   |   eth0      |  56.112.17.8/24 | router_lumenthi-4/eth1 |
+-------------------+-------------+-----------------+------------------------+
|                                 RR Router                                  |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-1 |   lo        |  xx.xxx.xx.x/xx | none                   |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-1 |   eth0      |  xx.xxx.xx.x/xx | router_lumenthi-2/eth0 |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-1 |   eth1      |  xx.xxx.xx.x/xx | router_lumenthi-3/eth0 |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-1 |   eth2      |  xx.xxx.xx.x/xx | router_lumenthi-4/eth0 |
+-------------------+-------------+-----------------+------------------------+
|                                 Leafs Routers                              |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-2 |   lo        |  xx.xxx.xx.x/xx | none                   |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-2 |   eth0      |  xx.xxx.xx.x/xx | router_lumenthi-1/eth0 |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-2 |   eth1      |  xx.xxx.xx.x/xx | host_lumenthi-1/eth0   |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-3 |   lo        |  xx.xxx.xx.x/xx | none                   |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-3 |   eth0      |  xx.xxx.xx.x/xx | router_lumenthi-1/eth0 |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-3 |   eth1      |  xx.xxx.xx.x/xx | host_lumenthi-2/eth0   |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-4 |   lo        |  xx.xxx.xx.x/xx | none                   |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-4 |   eth0      |  xx.xxx.xx.x/xx | router_lumenthi-1/eth0 |
+-------------------+-------------+-----------------+------------------------+
| router_lumenthi-4 |   eth1      |  xx.xxx.xx.x/xx | host_lumenthi-3/eth0   |
+-------------------+-------------+-----------------+------------------------+

# ===Steps===
# Hosts
1. Configure hosts IP addresses

# RR Router
2. Configure interfaces (eth0, eth1, eth2, lo)
3. Declare neighbors
$ router bgp 1
$ neighbor ibgp peer-group
$ neighbor ibgp remote-as 1
$ neighbor ibgp update-source lo
$ bgp listen range 1.1.1.0/29 peer-group ibgp
4. evpn, rr, ibgp activation
$ address-family l2vpn evpn
$ neighbor ibgp activate
$ neighbor ibgp route-reflector-client
$ exit-address-family
5. Enable ospf
network 0.0.0.0/0 area 0

# Leafs
6. Setup VxLAN, bridge like in P2
7. Setup interfaces (eth0, loopback)
