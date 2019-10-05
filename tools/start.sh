# Start the local XCache instance
#
# We do need a few arguments:
#  start.sh <rucio-username> <rucio_voms> <cert-password>

echo $*

rucio_username=$1
rucio_voms=$2
cert_pass=$3

# Load up other settings


# Get the certificate manager up and running
echo "" >> /var/spool/xrootd/.bashrc
echo export GRID_VOMS=${!rucio_voms:=$rucio_voms} >> /var/spool/xrootd/.bashrc
echo export GRID_PASSWORD=${!cert_pass:=$cert_pass} >> /var/spool/xrootd/.bashrc
echo export RUCIO_ACCOUNT=${!rucio_username:=$rucio_username} >> /var/spool/xrootd/.bashrc

cat /var/spool/xrootd/.bashrc

sudo -u xrootd /bin/bash -c "source /var/spool/xrootd/.bashrc; python3 cert_manager.py" &

# Give the system a chance to grab the first cert so we don't go into backoff mode.
sleep 15

# Next, start the xcache stuff
sudo -u xrootd /bin/bash -c ". /var/spool/xrootd/runme.sh"
