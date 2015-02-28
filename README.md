# usb-server

<t> USBinteraction </t>
=======

For <b> Effits </b> ltd. needs
Prepare for LightDM

------
Installation:
------
In your terminal,
Use that commands to install this software remote: 
```
    $ mkdir usb-server
    $ cd usb-server
    $ git clone git@effits.ru:/var/git/usb-server.git
    $ ./install
```
or just use one command if you have this pack physically:
```
	$ ./install
```

------
Description:
------
That pack includes 6 files:

"install" - for the installation setup & cleanup scripts into client system
"login" - Declare login info (setup script)
"logout" - Declare logout info (cleanup script)
"initdb" - create initial data base
"usb-server" - server part of USBinteraction Python3 script
"usb-connector" - responsible for final part of interaction: create and remove simlinks
"un-mount" - program to mount or unmount devices from client machine. Work automatically, starts from TCP request
-----
NOTA BENE!
first of all you need to install netifaces python module from using this commands:
```
	$tar xvzf netifaces-0.10.4.tar.gz
	$cd netifaces-0.10.4
	$python setup.py install
```
