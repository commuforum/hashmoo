#!/bin/bash
wget "https://dl.walletbuilders.com/download?customer=28d85c2edb6904ce8c88d1e9764aaf6c1ed84308e67a77858f&filename=hashmoo-qt-linux.tar.gz" -O hashmoo-qt-linux.tar.gz

mkdir $HOME/Desktop/Hashmoo

tar -xzvf hashmoo-qt-linux.tar.gz --directory $HOME/Desktop/Hashmoo

mkdir $HOME/.hashmoo

cat << EOF > $HOME/.hashmoo/hashmoo.conf
rpcuser=rpc_hashmoo
rpcpassword=dR2oBQ3K1zYMZQtJFZeAerhWxaJ5Lqeq9J2
rpcbind=0.0.0.0
rpcallowip=127.0.0.1
listen=1
server=1
addnode=node2.walletbuilders.com
EOF

cat << EOF > $HOME/Desktop/Hashmoo/start_wallet.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
./hashmoo-qt
EOF

chmod +x $HOME/Desktop/Hashmoo/start_wallet.sh

cat << EOF > $HOME/Desktop/Hashmoo/mine.sh
#!/bin/bash
SCRIPT_PATH=\`pwd\`;
cd \$SCRIPT_PATH
echo Press [CTRL+C] to stop mining.
while :
do
./hashmoo-cli generatetoaddress 1 \$(./hashmoo-cli getnewaddress)
done
EOF

chmod +x $HOME/Desktop/Hashmoo/mine.sh

exec $HOME/Desktop/Hashmoo/hashmoo-qt &

sleep 15

cd $HOME/Desktop/Hashmoo/

clear

exec $HOME/Desktop/Hashmoo/mine.sh