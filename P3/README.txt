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

# ==TODO==
- Steps description
- Complete IPs assignation in routers configs
- Must take masks in considerations when assigning IPs, it must not overlap
- Each leafs interfaces must be isolated with RR router and addresses must not overlap
