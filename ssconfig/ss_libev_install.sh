mkdir shadow
cd shadow
yum install git vim -y
yum install epel-release -y
yum install gcc gettext autoconf libtool automake make pcre-devel asciidoc xmlto udns-devel libev-devel mbedtls-devel -y

git clone https://github.com/shadowsocks/shadowsocks-libev.git
cd shadowsocks-libev
git submodule update --init --recursive

echo 'install libsodium'
export LIBSODIUM_VER=1.0.15
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
cd ..
rm -rf ./shadow
echo 'install completed'
