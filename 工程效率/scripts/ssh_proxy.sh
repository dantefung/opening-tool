#!/usr/bin/bash
PID=$(ps aux|grep ssh|grep fgnTN|grep -v grep |awk '{print $2}')
echo $PID
if [ $? -eq 0 -a ! -z "$PID" ]
then
 echo "SSH Proxy server is on..."
else
 echo "SSH Proxy server is death..."
 ssh -fgnTN -D 7079 yourusername@yourhostname
 if [ $? -eq 0 ]
 then
 echo "SSH Proxy Service restart successd."
 else
 echo "SSH Proxy Service restart failed."
 fi
fi
