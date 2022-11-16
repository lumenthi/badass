# ==HOST CONFIGURATION==
# Edit IP of the host in GNS3
eth0 -> 56.112.17.2/24

# ==ROUTER DAEMONS==
copy daemon file in /etc/frr/daemons to activate services
```
[...]
bgpd=yes
ospfd=yes
isisd=yes
[...]
```

# ==ROUTER COMMANDS==
# (vtysh config)

# Interfaces configuration
interface lo                        # Select loopback interface
 ip address 1.1.1.1/32              # Set its ip

interface eth0                      # Select eth0 interface
 ip address 56.112.17.4/30          # Set its ip


# OSPF configuration
router ospf                         # Activate and configure OSPF service
 network 56.112.17.1/24 area 0      # Declare range 56.112.17.0-56.112.17.255 in the backbone area (0)


# IS-IS Configuration
## For router 1
## $ net 49.0000.0000.0000.0001.00
## For router 2
## $ net 49.0000.0000.0000.0002.00

## The NSAP 47.0001.aaaa.bbbb.cccc.00 consists of:
##  Area =  47.0001
##  System ID =     aaaa.bbbb.cccc
##  N-Selector =                   00

router isis 1                       # Activate and configure is-is service number 1
 net 49.0000.0000.0001.00           # Select the NSAP number

interface lo                        # Select loopback interface
 ip router isis 1                   # Enable isis configuration n1 on this interface

interface eth0                      # Select eth0 interface
 ip router isis 1                   # Enable isis configuration n1 on this interface

router bgp 1                        # Enable bgp
