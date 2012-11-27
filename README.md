sioBuD.com
=========

#Libraries and tools used
* jQuery: http://jquery.com/
* Apache HTTPD: http://httpd.apache.org/
* CHICKEN Scheme: http://www.call-cc.org/
* Awful: http://wiki.call-cc.org/eggref/4/awful
* directory-utils: http://wiki.call-cc.org/eggref/4/directory-utils

#Setup
Awful can serve as standalone HTTP server, but I opted to use Apache
as a reverse proxy since I host other sites on my VPS.

##Apache
conf/siobud are my VirtualHost settings for sioBuD.com, I use Apache with
the mpm-itk patches (apache2-mpm-itk in Debian)

The website is setup to allow a non-privileged to view the logs and edit the code.
This also limits the amount of damage that can happen if the website is exploited.

##Init
conf/awful Goes into /etc/init.d/ this way I have awful spawn during init. It also 
allows me to easily reload the site when editing it from vim.

##CHICKEN
CHICKEN is (chicken-bin) in Debian. 

To install awful run (chicken-install awful directory-utils) you will need rw, so run this as root

##Awful config
(conf/awful.conf conf/privileged.conf) are both located in /etc/awful

These are the configs use by awful 
#License
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
