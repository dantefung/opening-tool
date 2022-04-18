wsl -u root ip addr add 192.168.33.10 broadcast 192.168.169.15 dev eth0 label eth0:1
netsh interface ip add address "vEthernet (WSL)" 192.168.33.1 255.255.255.240