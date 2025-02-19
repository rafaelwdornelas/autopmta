#!/bin/bash

# Atualiza o sistema e instala o unzip
sudo dnf update -y && sudo dnf install unzip -y

# Baixa e descompacta o pacote PowerMTA
wget -O PowerMTA-5.0r7.zip https://www.comerciojobsinformativos.issmarterthanyou.com/PowerMTA-5.0r7.zip
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
wget -O config https://raw.githubusercontent.com/rafaelwdornelas/autopmta/refs/heads/main/config

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
echo "pmta port: $pmtaport"  # Certifique-se de definir essa variável se necessário
echo "pmta mailaccount: support@$pmtahostname"
echo "pmta username: admin"
echo "pmta password: admin667788"
echo "============================================="
