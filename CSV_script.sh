#!/bin/sh

MY_INPUT= $1

#Creating groups
groupadd ftpUsers

while IFS=, read -r columnID columnPrenom columnNom columnMdp columnRole || [ -n "$columnRole" ];
do
        varusername=$columnPrenom$columnNom
        cleanvarusername="$(echo "${varusername}" | tr -d '[:space:]')"
        adduser -p $(openssl passwd -1 $columnMdp) $cleanvarusername
        usermod -aG ftpUsers $cleanvarusername
        cat configUsers.txt >> /etc/proftpd/proftpd.conf
        if [ $columnRole=Admin* ]; then
            usermod -aG sudo $cleanvarusername
        fi

done < $MY_INPUT
