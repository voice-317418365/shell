#!/bin/bash
exec 3<"3.0hosts"
exec 4<"3.0password"
while read ip<&3 && read pwd<&4
do
	sudo sshpass -p $pwd ssh-copy-id -i /root/.ssh/id_rsa.pub -o StrictHostKeyChecking=no root@$ip

done
