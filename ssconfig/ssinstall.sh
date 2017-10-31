mkdir shadow
yum install python-setuptools -y
easy_install pip
pip install shadowsocks
mkdir /etc/shadowsocks
curl "https://raw.githubusercontent.com/eshxcmhk/YeildSSH/master/ssconfig/shadowsocks.json" -o "shadowsocks.json"
cp shadowsocks.json /etc/shadowsocks/
curl "https://raw.githubusercontent.com/eshxcmhk/YeildSSH/master/ssconfig/ss.service" -o "shadowsocks.service"
cp shadowsocks.service /etc/systemd/system/
service firewalld start
echo "open port 8042/tcp"
firewall-cmd --zone=public --add-port=8042/tcp --permanent
echo "open port 8042/udp"
firewall-cmd --zone=public --add-port=8042/udp --permanent
echo "open port 9042/tcp"
firewall-cmd --zone=public --add-port=9042/tcp --permanent
echo "open port 9042/udp"
firewall-cmd --zone=public --add-port=9042/udp --permanent
echo "open port 18042/tcp"
firewall-cmd --zone=public --add-port=18042/tcp --permanent
echo "open port 18042/udp"
firewall-cmd --zone=public --add-port=18042/udp --permanent
firewall-cmd --reload 
systemctl enable shadowsocks
systemctl start shadowsocks
systemctl status shadowsocks -l
cd ..
rm -rf shadow
