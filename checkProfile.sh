if [ -f /opt/IBM/WebSphere/wp_profile/bin/startServer.sh ]; then

    exit

else

    cp -a /mnt/storage/wp_profile/. /opt/IBM/WebSphere/wp_profile/

    wait

fi
