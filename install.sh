#!/bin/bash

# Atualiza o sistema e instala o unzip e o curl (caso ainda não estejam instalados)
sudo dnf update -y && sudo dnf install unzip curl -y

# Baixa e descompacta o pacote PowerMTA
curl -o PowerMTA-5.0r7.zip https://www.comerciojobsinformativos.issmarterthanyou.com/PowerMTA-5.0r7.zip
unzip -q PowerMTA-5.0r7.zip
rm -rf PowerMTA-5.0r7.zip

# Instala o pacote RPM do PowerMTA
sudo rpm -ivh PowerMTA-5.0r7.rpm

# Move a licença e os binários para os locais corretos
sudo mv patch/etc/pmta/license /etc/pmta
sudo mv patch/usr/sbin/* /usr/sbin
sudo chmod -R 755 /usr/sbin/pmtad
sudo chmod -R 755 /usr/sbin/pmtahttpd
sudo rm -rf PowerMTA-5.0r7.rpm
sudo rm -rf patch

# Baixa o arquivo de configuração
curl -o config https://raw.githubusercontent.com/rafaelwdornelas/autopmta/refs/heads/main/config

echo -n "your pmta hostname: "
read pmtahostname

# Para o serviço do PowerMTA (utilizando systemd)
sudo systemctl stop pmta

# Move o arquivo de configuração para o diretório correto
sudo mv config /etc/pmta

# Substitui o placeholder QQQhostnameQQQ pelo hostname informado
sudo sed -i "s/QQQhostnameQQQ/$pmtahostname/g" $(grep "QQQhostnameQQQ" -rl /etc/pmta/)

# Reinicia o serviço do PowerMTA
sudo systemctl restart pmta

echo "your pmta install success!"
echo "============================================="
echo "pmta host: $pmtahostname"
echo "pmta mailaccount: support@$pmtahostname"
echo "pmta username: admin"
echo "pmta password: admin667788"
echo "============================================="
