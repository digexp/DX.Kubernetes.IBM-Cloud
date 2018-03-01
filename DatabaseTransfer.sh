#!/bin/sh
cd "`dirname "$0"`"
# =================================================================== #
# Job name: DatabaseTransfer #   
#                                                                     #
# Purpose:                                                            #
#                                                                    #   
#                                                                     #
# =================================================================== #
# Generated Fri Feb 02 19:04:17 UTC 2018 from step 'Transfer the database'.
# Driver Number: 8.0.0.0
        
# ******************************************************************* #
#  Run ConfigEngine.sh shell script                                   #
# ******************************************************************* #
  /opt/IBM/WebSphere/wp_profile/ConfigEngine/ConfigEngine.sh  -DSaveParentProperties=true -DparentProperties="/root/DatabaseTransfer.properties" -DWasPassword=wpsadmin -DTransferDomainList=feedback,likeminds,release,community,customization,jcr database-transfer enable-profiles-check-managed package-profiles -DWasPassword="wpsadmin" -Drelease.DBA.DbPassword="@pwd@" -Drelease.DbPassword="@pwd@" -Dcustomization.DbPassword="@pwd@" -Dcustomization.DBA.DbPassword="@pwd@" -Dcommunity.DbPassword="@pwd@" -Dcommunity.DBA.DbPassword="@pwd@" -Djcr.DbPassword="@pwd@" -Djcr.DBA.DbPassword="@pwd@" -Dlikeminds.DBA.DbPassword="@pwd@" -Dlikeminds.DbPassword="@pwd@" -Dfeedback.DBA.DbPassword="@pwd@" -Dfeedback.DbPassword="@pwd@"
  TASK_RC=$?


exit $TASK_RC
