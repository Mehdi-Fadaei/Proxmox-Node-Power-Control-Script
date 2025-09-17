# Proxmox-Node-Power-Control-Script
This repository contains a simple Bash script to control multiple Proxmox nodes remotely. It supports Wake-on-LAN (WOL) to power on nodes and SSH shutdown to power them off.  Perfect for a small Proxmox homelab where you want to start and stop nodes easily from one main node.
Features

✅ Power on all nodes at once
✅ Power off all nodes at once
✅ Power on a single node
✅ Power off a single node
✅ Easy to customize (just edit IPs & MAC addresses)

Requirements

All nodes must have Wake-on-LAN enabled in BIOS and OS.

ethtool installed on each node.

wakeonlan installed on the control node (pve).

Passwordless SSH configured from the control node to all other nodes.

Installation

Enable Wake-on-LAN on each node

BIOS: Enable "Wake on PCI-E" / "Wake on LAN"

OS:
Replace eno1 with yout Interface Name. Important 

apt update && apt install ethtool -y
ethtool -s eno1 wol g
echo 'post-up /sbin/ethtool -s eno1 wol g' >> /etc/network/interfaces

Install required tools on the control node (pve)

apt install wakeonlan -y


Setup passwordless SSH

ssh-keygen -t rsa -b 4096
ssh-copy-id root@192.x.x.x
ssh-copy-id root@192.x.x.xx
ssh-copy-id root@192.x.x.xxx
ssh-copy-id root@192.x.x.xxx

Replace ip white you cluster proxmox id 


Download the script

wget https://github.com/<your-repo>/nodes-control.sh
chmod +x nodes-control.sh


Edit the script and update the MAC/IP addresses of your nodes:

nano nodes-control.sh


Replace with your own network details.

Usage

Run the script from your control node (pve):

./nodes-control.sh on-all      # Power ON all nodes
./nodes-control.sh off-all     # Power OFF all nodes
./nodes-control.sh on-one pve3 # Power ON pve3 only
./nodes-control.sh off-one pve3# Power OFF pve3 only


Example output:

Sending magic packet to pve3 (AA:BB:CC:DD:EE:03)...
pve3 will power on shortly.
