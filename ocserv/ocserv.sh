mkdir ocserv
cd ocserv

mkdir -p /etc/ssl/private
curl https://raw.githubusercontent.com/eshxcmhk/YeildSSH/master/ocserv/ca/ca-cert.pem -o /etc/ssl/private/ca-cert.pem --progress
curl https://raw.githubusercontent.com/eshxcmhk/YeildSSH/master/ocserv/ca/server-cert.pem -o /etc/ssl/certs/server-cert.pem --progress
curl https://raw.githubusercontent.com/eshxcmhk/YeildSSH/master/ocserv/ca/server-key.pem -o /etc/ssl/private/server-key.pem --progress

yum -y install epel-release
yum -y install ocserv

mv -n /etc/ocserv/ocserv.conf /etc/ocserv/ocserv.conf.back
curl https://raw.githubusercontent.com/eshxcmhk/YeildSSH/master/ocserv/ocserv.conf -o /etc/ocserv/ocserv.conf  --progress

service firewalld start
echo "open port 8142/tcp"
firewall-cmd --zone=public --add-port=8142/tcp --permanent
echo "open port 8142/udp"
firewall-cmd --zone=public --add-port=8142/udp --permanent

firewall-cmd --permanent --zone=public --change-interface=eth0
firewall-cmd --zone=public --add-masquerade --permanent
firewall-cmd --permanent --direct --passthrough ipv4 -t nat POSTROUTING -o eth0 -j MASQUERADE -s 192.168.80.0/24

firewall-cmd --reload

cd ..
rm -rf ocserv
