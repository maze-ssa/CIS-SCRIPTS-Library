 #On disk configuration
 
 {
awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&/ -S/ \
&&(/sethostname/ \
 ||/setdomainname/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules
awk '/^ *-w/ \
&&(/\/etc\/issue/ \
 ||/\/etc\/issue.net/ \
 ||/\/etc\/hosts/ \
 ||/\/etc\/sysconfig\/network/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules
}


#Running configuration

{
auditctl -l | awk '/^ *-a *always,exit/ \
&&/ -F *arch=b(32|64)/ \
&&/ -S/ \
&&(/sethostname/ \
 ||/setdomainname/) \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'
auditctl -l | awk '/^ *-w/ \
&&(/\/etc\/issue/ \
 ||/\/etc\/issue.net/ \
 ||/\/etc\/hosts/ \
 ||/\/etc\/sysconfig\/network/) \
&&/ +-p *wa/ \
&&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'
}

#remediate
printf " -a always,exit -F arch=b64 -S sethostname,setdomainname -k system-locale -a always,exit -F arch=b32 -S sethostname,setdomainname -k system-locale -w /etc/issue -p wa -k system-locale -w /etc/issue.net -p wa -k system-locale -w /etc/hosts -p wa -k system-locale -w /etc/sysconfig/network -p wa -k system-locale -w /etc/sysconfig/network-scripts/ -p wa -k system-locale " >> /etc/audit/rules.d/50-system_local.rules
augenrules --load
if [[ $(auditctl -s | grep "enabled") =~ "2" ]]; then printf "Reboot required to load rules\n"; fi