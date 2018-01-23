mkdir shadow
cd shadow
yum install git vim -y
yum install epel-release -y
yum install gcc gettext autoconf libtool automake make pcre-devel asciidoc xmlto udns-devel libev-devel mbedtls-devel -y

git clone https://github.com/shadowsocks/shadowsocks-libev.git
cd shadowsocks-libev
git submodule update --init --recursive

echo 'install libsodium'
export LIBSODIUM_VER=1.0.13
wget https://download.libsodium.org/libsodium/releases/libsodium-$LIBSODIUM_VER.tar.gz
tar xvf libsodium-$LIBSODIUM_VER.tar.gz
pushd libsodium-$LIBSODIUM_VER
./configure --prefix=/usr && make
make install
popd
ldconfig

echo 'compile shadowsocks-libev'
./autogen.sh && ./configure --prefix=/usr && make
sudo make install

mkdir -p /etc/shadowsocks-libev
curl "https://raw.githubusercontent.com/eshxcmhk/YeildSSH/master/ssconfig/shadowsocks.json" -o "shadowsocks.json"
cp shadowsocks.json /etc/shadowsocks-libev/
curl "https://raw.githubusercontent.com/eshxcmhk/YeildSSH/master/ssconfig/ss.service" -o "shadowsocks.service"
cp shadowsocks.service /etc/systemd/system/
service firewalld start
echo "open port 8042/tcp"
firewall-cmd --zone=public --add-port=8042/tcp --permanent
echo "open port 8042/udp"
firewall-cmd --zone=public --add-port=8042/udp --permanent
# echo "open port 9042/tcp"
# firewall-cmd --zone=public --add-port=9042/tcp --permanent
# echo "open port 9042/udp"
# firewall-cmd --zone=public --add-port=9042/udp --permanent
# echo "open port 18042/tcp"
# firewall-cmd --zone=public --add-port=18042/tcp --permanent
# echo "open port 18042/udp"
# firewall-cmd --zone=public --add-port=18042/udp --permanent
# firewall-cmd --reload 
systemctl enable shadowsocks
systemctl start shadowsocks
systemctl status shadowsocks -l
cd ..
rm -rf ./shadow
