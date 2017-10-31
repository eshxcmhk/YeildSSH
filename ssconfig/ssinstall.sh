mkdir shadow
yum install python-setuptools -y
easy_install pip
pip install shadowsocks
curl "https://raw.githubusercontent.com/eshxcmhk/YeildSSH/master/ssconfig/shadowsocks.json" -o "shadowsocks.json"
firewall-cmd --zone=public --add-port=8042/tcp --permanent
firewall-cmd --zone=public --add-port=9042/tcp --permanent
firewall-cmd --zone=public --add-port=18042/tcp --permanent
firewall-cmd --zone=public --add-port=8042/udp --permanent
firewall-cmd --zone=public --add-port=9042/udp --permanent
firewall-cmd --zone=public --add-port=18042/udp --permanent
ssserver -c ~/shadow/shadowsocks.json -d start
