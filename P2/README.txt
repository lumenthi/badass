# ===IPs configuration===

+-------------------+------------------------+-----------------+------------------------+
| HOST              |   INTERFACE            |      IP         |        LINK            |
+-------------------+------------------------+-----------------+------------------------+
| host_lumenthi-1   |   eth0                 |  56.112.17.6/24 | router_lumenthi-1/eth1 |
+-------------------+------------------------+-----------------+------------------------+
| host_lumenthi-2   |   eth0                 |  56.112.17.7/24 | router_lumenthi-2/eth1 |
+-------------------+------------------------+-----------------+------------------------+
| router_lumenthi-1 |   eth0                 |  36.112.17.4/24 | switch_lumenthi        |
+-------------------+------------------------+-----------------+------------------------+
| router_lumenthi-1 |   eth1                 |  56.112.17.4/24 | host_lumenthi-1/eth0   |
+-------------------+------------------------+-----------------+------------------------+
| router_lumenthi-2 |   eth0                 |  36.112.17.5/24 | switch_lumenthi        |
+-------------------+------------------------+-----------------+------------------------+
| router_lumenthi-2 |   eth1                 |  56.112.17.5/24 | host_lumenthi-2/eth0   |
+-------------------+------------------------+-----------------+------------------------+

# === Steps===

## Hosts
1. Give IPs to hosts machines
## Routers
2. Give IPs to routers
# VxLAN interface
3. Create and configure VxLAN interface
# For unicast
$ ip link add name vxlan10 type vxlan id 10 dev eth0 remote <eth0 address of the other router> local <eth0 address of the current router> dstport 4789
# For multicast
$ ip link add name vxlan10 type vxlan id 10 dev eth0 group <group IP> dstport 4789
4. Activate it
5. Give vxlan10 the same IP address than eth1
$ ip addr add 56.112.18.4/24 dev vxlan10
# Bridge
6. Create bridge br0 then activate it
7. Add vxlan10 and eth1 to the bridge

# ===Links===
https://serverfault.com/questions/874438/set-up-bridged-vxlan-network-in-linux
https://vincent.bernat.ch/en/blog/2017-vxlan-linux
https://www.youtube.com/watch?v=u1ka-S6F9UI
