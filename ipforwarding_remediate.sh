printf " net.ipv4.ip_forward = 0 " >> /etc/sysctl.d/60-netipv4_sysctl.conf
{ sysctl -w net.ipv4.ip_forward=0 sysctl -w net.ipv4.route.flush=1 }
printf " net.ipv6.conf.all.forwarding = 0 " >> /etc/sysctl.d/60-netipv6_sysctl.conf
{ sysctl -w net.ipv6.conf.all.forwarding=0 sysctl -w net.ipv6.route.flush=1 }