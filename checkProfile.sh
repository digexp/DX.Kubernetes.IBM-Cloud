# Check for start script to determine if volume is populated
# New deployments will need to copy the profile to the volume
# This will only need to be done on the first image deployment
if [ -f /opt/IBM/WebSphere/wp_profile/bin/startServer.sh ]  #check if PV populated
then
    echo "PV is populated"
    exit  #contents already copied, we can exit
else
    cp -a /mnt/storage/wp_profile/. /opt/IBM/WebSphere/wp_profile/  #populate PV with profile contents
    wait
fi
echo "Completed copy of wp_profile to PV NFS"
