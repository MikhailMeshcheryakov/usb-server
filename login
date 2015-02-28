#!/usr/bin/env python3

import os, sqlite3, sys, logging, string, netifaces
from subprocess import Popen

LOG_FILENAME = '/var/log/system.log'
DATABASE_FILENAME = '/var/init.db'

logging.basicConfig(filename=LOG_FILENAME, filemode='a', level=logging.error)

def main():
	display = os.environ['DISP']
	user = os.environ['USER']

	def isUserNameCorr(usr):
		isUserNameContains = string.ascii_letters + string.digits + '_' + '-' + '.'
		return all(c in isUserNameContains for c in user)
	def isDisplayCorr(disp):
		isDisplayContains = string.digits
		return all(c in isDisplayContains for c in display)

	if not isUserNameCorr(user) or not isDisplayCorr(display):
		raise ValueError

	try:
		conn = sqlite3.connect(DATABASE_FILENAME)
		cur  = conn.cursor()

		cur.execute('INSERT INTO users ({0}, {1});'.format(display, user))

		mPoints = cur.execute('SELECT mountPoint FROM mountPoints \
			WHERE PID=Null AND Disp={0}'.format(display))
		for mPoint in mPoints:
			addrs = ni.ifaddresses('eth0')[AF_INET][0]['addr'] #need to install module netifaces from pypi
			addrsLastOctet = addrs.split('.')[-1]
			if addrsLastOctet != display:
				raise ValueError
			connector = subprocess.popen('usb-connector', mPoint, addrs)
			pid = connector.pid #TODO: get sshfs pid, not connector
			cur.execute('UPDATE mountPoints SET PID={0} \
				WHERE mountPoint={1}'.format(pid, mPoint))
		conn.commit()
	except Exception as err:
		logging.critical(err)
		raise err
	finally:
		if conn:
			conn.close()
if __name__ == '__main__':
    main()
