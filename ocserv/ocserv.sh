mkdir ocserv
cd ocserv

mkdir -p /etc/ssl/private
mkdir -p /etc/ssl/certs
curl https://raw.githubusercontent.com/eshxcmhk/YeildSSH/master/ocserv/ca-cert.pem -o /etc/ssl/private/ca-cert.pem --progress
curl https://raw.githubusercontent.com/eshxcmhk/YeildSSH/master/ocserv/server-cert.pem -o /etc/ssl/certs/server-cert.pem --progress
curl https://raw.githubusercontent.com/eshxcmhk/YeildSSH/master/ocserv/server-key.pem -o /etc/ssl/private/server-key.pem --progress

cd ..
rm -rf ocserv
