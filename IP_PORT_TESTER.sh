#!/bin/bash

# Get the IP address from the user
read -p "Enter the IP address: " IP

# Define an array of common ports to check
PORTS=(22 80 443 8080 3306 21 25 53)

# Check if the IP address is provided
if [ -z "$IP" ]; then
  echo "IP address is required."
  exit 1
fi

# Ping the IP address to see if it's reachable
echo "Pinging IP address $IP..."
ping -c 1 $IP > /dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "IP $IP is reachable."
else
  echo "IP $IP is not reachable."
  exit 1
fi

# Loop through the array of ports and check if they are open
for PORT in "${PORTS[@]}"; do
  echo "Checking port $PORT on IP $IP..."
  nc -zv $IP $PORT 2>&1 | grep succeeded > /dev/null

  if [ $? -eq 0 ]; then
    echo "Port $PORT is open on $IP."
  else
    echo "Port $PORT is closed on $IP."
  fi
done

