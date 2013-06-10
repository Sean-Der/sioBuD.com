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
The MIT License (MIT)

Copyright (c) 2013 Sean DuBois

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
