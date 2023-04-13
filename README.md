# Install And Manage L2TP-IPSec with PSK Authentication

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

If you need to make sure vpn is always connected all job bellow to crontab:
~~~
 * * * * sudo [path]/task.sh
~~~
make sure you replace [path] with right unix path
