# Install And Manage L2TP-IPSec with PSK Authentication

* Tested On Ubuntu 22

### Install / Configure
~~~shell
sudo ./install.sh [vpn_server_ip] [psk] [user] [password]
~~~

### Connect
~~~shell
sudo ./connect.sh
~~~

### Disconnect
~~~shell
sudo ./disconnect.sh
~~~


### Cronjob
If you need to make sure that the vpn is always connected, all you have to do is add the following job to the crontab:
~~~
 * * * * sudo [path]/task.sh
~~~
Make sure you replace [path] with the correct one for you
