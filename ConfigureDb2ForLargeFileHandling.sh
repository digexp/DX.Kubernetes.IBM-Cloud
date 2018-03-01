#!/bin/sh
cd "`dirname "$0"`"
CW_SCRIPTS_HOME=`pwd`
# =================================================================== #
# Job name: ConfigureDb2ForLargeFileHandling #   
#                                                                     #
# Purpose:                                                            #
#                                                                    #   
#                                                                     #
# =================================================================== #
# Generated Fri Feb 02 19:04:17 UTC 2018 from step 'Configure DB2 For Large File Handling'.
# Driver Number: 8.0.0.0
        
# ******************************************************************* #
#  Run ConfigEngine.sh shell script                                   #
# ******************************************************************* #
  /opt/IBM/WebSphere/wp_profile/ConfigEngine/ConfigEngine.sh  -DWasPassword=wpsadmin datasource-enable-fully-materialize-lob-data -DWasPassword="wpsadmin"
  TASK_RC=$?


exit $TASK_RC
