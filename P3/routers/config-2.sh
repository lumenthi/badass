# Interface
ip addr add 36.112.17.5/24 dev eth0 # eth0 IP
ip addr add 56.112.17.5/24 dev eth1 # eth1 IP
echo "Default interfaces configuration done."

# VxLAN interface creation and setup
# Unicast
# ip link add name vxlan10 type vxlan id 10 dev eth0 remote 36.112.17.4 local 36.112.17.5 dstport 4789 # Add vxlan interface id 10 using interface eth0
# Multicast
ip link add name vxlan10 type vxlan id 10 dev eth0 group 239.1.1.1 dstport 4789
ip link set dev vxlan10 up # Activate interface
ip addr add 56.112.17.5/24 dev vxlan10 # Give eth1 and vxlan10 the same IP address
echo "VxLAN interface configuration done."

# Bridge creation and setup
ip link add br0 type bridge # Create bridge
ip link set dev br0 up # Activate bridge
brctl addif br0 eth1 # Add eth1 to br0
brctl addif br0 vxlan10 # Add vxlan10 to bridge
echo "Bridge configuration done."
