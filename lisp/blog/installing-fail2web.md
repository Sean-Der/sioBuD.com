#Introduction

While in theory it would be nice to have every network service behind a LAN/certificate that isn't always possible.
Many protocols don't have certificate authentication, and even if they do maybe your client doesn't support it. So you
are left with password authentication, but what happens when someone uses a 4 char password... and an attacker is able
to guess 1000 times every minute? Seems like a complicated problem, but not with [fail2ban](http://www.fail2ban.org/wiki/index.php/Main_Page)!
The following description is lifted from the fail2ban documentation.

However, once I installed fail2ban I found myself locking myself out of my servers all the time! I would setup a SIP client to use the wrong password,
and would spend way to much time debugging what was wrong! With fail2web, that is all a thing of the past! fail2web is a mobile first GUI to fail2ban,
that allows you to view who is currently banned, test regexes and view graphs on past bans.

###Unbanning Users
<img class="centered-image" src="http://i.imgur.com/Duy0aKM.gif" />

##Testing Regexes
<img class="centered-image" src="http://i.imgur.com/vDKYnql.gif" />

##Requirements

Even though this tutorial is written for Ubuntu, it should work on any host that has Golang and fail2ban (All Unixes). You might have to deviate
from this tutorial, but it should covert most of it.


#Installing fail2rest

First we need to install fail2rest, the daemon that communicates with fail2ban. The backend requires the Go programming language, and git to download it.
If you have never used Go before you can follow this verbatim, adjust as needed if you already have a Gopath set.

###Install the necessary libraries

* `sudo apt-get install golang git gcc`

###Download fail2rest

* `go get github.com/Sean-Der/fail2rest`

###Enter the fail2rest folder

* `cd $GOPATH/src/github.com/Sean-Der/fail2rest`

###Start fail2rest

* `sudo -E go run *.go`

<br />

If everything worked this program should just run forever! We will update it to run as a service later, but make sure it is working first.
Run `wget -qO- -- "localhost:5000/global/ping"` if that returns "pong" you have a running fail2rest instance!

#Installing fail2web

Next we are going to install fail2web in /var/www/fail2web, later we will access this via apache

###Download fail2web

* `git clone --depth=1 https://github.com/Sean-Der/fail2web.git /var/www/fail2web`

###Delete the .git directory

* `rm -rf !$/.git`


<br />

Congrats, you are almost done! You now have all the moving parts, all that is left is to serve it via Apache

#Access it via Apache
Next we need to create a vhost config for fail2web, and put it behind a password

###Install Apache

* `sudo apt-get install apache2 apache2-utils`

###Setting a password
Make sure to replace YOUR_USERNAME

* `sudo htpasswd -c /var/www/htpasswd YOUR_USERNAME`

###Enable the Apache modules needed for ProxyPass

* `sudo a2enmod proxy proxy_ajp proxy_http rewrite deflate headers proxy_balancer proxy_connect proxy_html`

###Create your fail2web config

Then with your text editor of choice create `/etc/apache2/sites-enabled/fail2web.conf` with the following content.
Make sure to replace `fail2web.yourserver.name`

    <VirtualHost *:80>
      ServerName fail2web.yourserver.com ##CHANGE THIS
      DocumentRoot /var/www/fail2web/web

      <Location />
          AuthType Basic
          AuthName "Restricted"
          AuthBasicProvider file
          AuthUserFile /var/www/htpasswd
          Require valid-user

      </Location>

     ProxyPass /api http://127.0.0.1:5000

    </VirtualHost>

###Restart Apache!

fail2web should now be accessible via the ServerName you chose above

###Cleaning Up

TODO
