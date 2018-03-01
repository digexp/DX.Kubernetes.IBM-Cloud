#!/bin/sh
cd "`dirname "$0"`"
CW_SCRIPTS_HOME=`pwd`
# =================================================================== #
# Job name: BackupPropertyFiles #   
#                                                                     #
# Purpose:                                                            #
#                                                                    #   
#                                                                     #
# =================================================================== #
# Generated Fri Feb 02 19:04:17 UTC 2018 from step 'Backing up the property files'.
# Driver Number: 8.0.0.0
        
# ******************************************************************* #
#  Run ConfigEngine.sh shell script                                   #
# ******************************************************************* #
  /opt/IBM/WebSphere/wp_profile/ConfigEngine/ConfigEngine.sh  -DWasPassword=wpsadmin backup-property-files-for-dbxfer -DWasPassword="wpsadmin"
  TASK_RC=$?


exit $TASK_RC
