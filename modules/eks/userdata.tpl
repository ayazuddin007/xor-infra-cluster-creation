MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="

--==MYBOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
set -ex
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

yum install -y amazon-ssm-agent
systemctl enable amazon-ssm-agent && systemctl start amazon-ssm-agent
sudo echo "[Unit]
Description=Restore iptables
# iptables-restore must start after docker because docker will
# reconfigure iptables to drop forwarded packets.
After=docker.service

[Service]
Type=oneshot
ExecStart=/bin/bash -c '/sbin/iptables-restore < /etc/sysconfig/iptables'

[Install]
WantedBy=multi-user.target
" >> /etc/eks/iptables-restore.service

sudo /etc/eks/bootstrap.sh ${CLUSTER_NAME} --b64-cluster-ca ${B64_CLUSTER_CA} --apiserver-endpoint ${API_SERVER_URL}

--==MYBOUNDARY==--