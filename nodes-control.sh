#!/bin/bash
# nodes-control.sh
# Control Proxmox nodes via WOL & SSH

# Define IPs and MAC addresses
declare -A NODES
NODES=(
  [pve1_ip]="192.168.10.101"
  [pve1_mac]="AA:BB:CC:DD:EE:01"

  [pve2_ip]="192.168.10.102"
  [pve2_mac]="AA:BB:CC:DD:EE:02"

  [pve3_ip]="192.168.10.103"
  [pve3_mac]="AA:BB:CC:DD:EE:03"

  [pve4_ip]="192.168.10.104"
  [pve4_mac]="AA:BB:CC:DD:EE:04"
)

function power_on_all {
  for i in 1 2 3 4; do
    wakeonlan "${NODES[pve${i}_mac]}"
  done
}

function power_off_all {
  for i in 1 2 3 4; do
    ssh root@"${NODES[pve${i}_ip]}" "shutdown -h now" &
  done
  wait
}

function power_on_one {
  local node=$1
  wakeonlan "${NODES[${node}_mac]}"
}

function power_off_one {
  local node=$1
  ssh root@"${NODES[${node}_ip]}" "shutdown -h now"
}

case $1 in
  on-all) power_on_all ;;
  off-all) power_off_all ;;
  on-one) power_on_one $2 ;;
  off-one) power_off_one $2 ;;
  *)
    echo "Usage: $0 {on-all|off-all|on-one NODE|off-one NODE}"
    echo "Example: $0 on-one pve2"
    ;;
esac
