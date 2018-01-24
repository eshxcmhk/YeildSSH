VERSION=1.12.2
yum install -y openssl-devel pcre-devel
mkdir -p nginx
cd nginx
wget http://nginx.org/download/nginx-${VERSION}.tar.gz
tar zxf nginx-${VERSION}.tar.gz
cd nginx-${VERSION}
useradd -M -s /sbin/nologin nginx
./configure --prefix=/usr/local/nginx --with-http_dav_module --with-http_stub_status_module  --with-http_addition_module --with-http_sub_module  --with-http_flv_module --with-http_mp4_module --with-pcre --with-http_ssl_module --with-http_gzip_static_module  --user=nginx  --group=nginx
make && make install
ln -s /usr/local/nginx/sbin/nginx /usr/local/sbin/

echo "open port 80/tcp"
firewall-cmd --zone=public --add-port=80/tcp
firewall-cmd --zone=public --add-port=80/udp
