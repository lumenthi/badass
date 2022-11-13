# ===IPs configuration===
HOST			INTERFACE		IP		LINK
# H1
host_lumenthi-1		eth0			56.112.17.6/24	router_lumenthi-1/eth1
# H2
host_lumenthi-2		eth0			56.112.17.7/24	router_lumenthi-2/eth1
# R1
router_lumenthi-1	loopback		1.1.1.1/32	None
router_lumenthi-1	eth0			36.112.17.4/24	switch_lumenthi
router_lumenthi-1	eth1			56.112.17.4/24	host_lumenthi-1/eth0
# R2
router_lumenthi-2	loopback		1.1.1.2/32	None
router_lumenthi-2	eth0			36.112.17.5/24	switch_lumenthi
router_lumenthi-2	eth1			56.112.17.5/24	host_lumenthi-2/eth0

# ===ISIS==
HOST			CLNS
router_lumenthi-1	49.0000.0000.0001.00
router_lumenthi-2	49.0000.0000.0002.00

# === Steps===
## Hosts
1. Give IPs to hosts machines
## Routers
2. Give IPs to routers
# VxLAN interface
3. Create and configure VxLAN interface
# Unicast
$ ip link add name vxlan10 type vxlan id 10 dev eth0 remote <eth0 address of the other router> local <eth0 address of the current router> dstport 4789
4. Activate it
5. Give vxlan10 the same IP address than eth1
$ ip addr add 56.112.18.4/24 dev vxlan10
# Bridge
6. Create bridge br0 then activate it
7. Add vxlan10 and eth1 to the bridge
# VxLAN Multicast
8. Enable multicast
$ ip link add name vxlan10 type vxlan id 10 dev eth0 group 239.1.1.1 dstport 4789
$ ip link set vxlan10 master br0
$ ip link set vxlan10 up

# ===Debug===
$ ip -d link show vxlan10
$ ip link show vxlan10
$ ip link show eth1

# ===Links===
https://serverfault.com/questions/874438/set-up-bridged-vxlan-network-in-linux
https://vincent.bernat.ch/en/blog/2017-vxlan-linux
https://www.youtube.com/watch?v=u1ka-S6F9UI

# ===TODO===
must change IP addresses according to IP confs
