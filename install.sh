sudo apt-get update && sudo apt-get install rpm unzip

wget -O PowerMTA-5.0r7.zip https://www.comerciojobsinformativos.issmarterthanyou.com/PowerMTA-5.0r7.zip
unzip -q PowerMTA-5.0r7.zip
rm -rf PowerMTA-5.0r7.zip
rpm -ivh PowerMTA-5.0r7.rpm
mv patch/etc/pmta/license /etc/pmta
mv patch/usr/sbin/* /usr/sbin
chmod -R 755 /usr/sbin/pmtad
chmod -R 755 /usr/sbin/pmtahttpd
rm -rf PowerMTA-5.0r7.rpm
rm -rf patch

wget -O config https://raw.githubusercontent.com/rafaelwdornelas/autopmta/refs/heads/main/config


echo -n "your pmta ip:"
read pmtaip
echo -n "your pmta hostname:"
read pmtahostname
echo -n "your pmta port:"
read pmtaport

service pmta stop
mv config /etc/pmta


sed -i "s/QQQipQQQ/$pmtaip/g" `grep "QQQipQQQ" -rl /etc/pmta/`
sed -i "s/QQQhostnameQQQ/$pmtahostname/g" `grep "QQQhostnameQQQ" -rl /etc/pmta/`
sed -i "s/QQQportQQQ/$pmtaport/g" `grep "QQQportQQQ" -rl /etc/pmta/`

service pmta restart
echo "your pmta install success!"
echo "============================================="
echo "pmta host:$pmtahostname"
echo "pmta port:$pmtaport"
echo "pmta mailaccount:support@$pmtahostname"
echo "pmta username:admin"
echo "pmta password:admin667788"
echo "============================================="
