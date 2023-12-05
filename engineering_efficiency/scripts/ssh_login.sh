#!/usr/bin/expect
 set password "yourpassword"
 spawn ssh yourusername@yourdomain
 expect "yourusername@yourdomain's password:"
 send "$password"
 expect eof 
 interact
