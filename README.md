# Digital Experience on IBM Cloud in a Kubernetes Cluster
## Running IBM WebSphere Portal V9.0 Docker container on IBM Cloud in a Kubernetes Cluster

For information about IBM Cloud and Kubernetes, go to: Getting started with IBM Cloud Container Service
https://console.bluemix.net/docs/containers/container_index.html#container_index

Use the contents of this github repository to extend an image of IBM WebSphere Portal or IBM Web Content Manager that was created using the Dockerfile scripts posted at the [IBM WebSphere Portal Server and Web Content Manager V9.0 Git Repository](https://github.com/digexp/ci.docker.websphere-portal).  The extended image starts the WebSphere_Portal server when the container is started using ports configured for access when running in a Kubernetes pod on IBM Cloud.

* Step 1:  Start the existing IBM WebSphere Portal or Web Content Manager V9.0 image and build a new image using the Dockerfile above and instructions in this readme.

* Step 2:  Deploy the extended IBM WebSphere Portal or Web Content Manager V9.0 image to Kubernetes using the YAML files above and instructions in this readme.

******************************************************************

The following instructions can be used to extend an existing WebSphere Portal Server or Web Content Manager V9.0 docker image running on CentOS7 previously built using instructions at this [repository](https://github.com/digexp/ci.docker.websphere-portal).  

### Assumptions:

Pre-requisites for the existing [WebSphere Portal Server](https://github.com/digexp/ci.docker.websphere-portal/tree/master/IBMWebSpherePortalServerV9.0), [Web Content Manager](https://github.com/digexp/ci.docker.websphere-portal/tree/master/IBMWebContentManagerV9.0), or WebSphere Portal Server and Web Content Manager (with [Enable](https://github.com/digexp/ci.docker.websphere-portal/tree/master/IBMWebSpherePortalEnableV9.0), [Extend](https://github.com/digexp/ci.docker.websphere-portal/tree/master/IBMWebSpherePortalExtendV9.0)) V9.0 image have been met.  

### Building the WebSphere Portal Server or Web Content Manager V9.0 image

#### Clone this repository
Use git or github to clone this repository.

#### Build the extended WebSphere Portal Server or Web Content Manager V9.0 docker image

Run the following command in a new command or terminal window to build the new docker image:

```
docker build -t dxen:v90 .
```

* This command takes around 5 minutes to complete.

The `dxen:v90` image is a fully functional single node WebSphere Portal or Web Content Manager V9.0 with ports configured for deployment to a Kubernetes cluster on a WebSphere Application Server V9.0 installation using Derby.  

******************************************************************

### DEPLOYMENT TO KUBERNETES in IBM CLOUD:  

Complete the following instructions to deploy the extended WebSphere Portal Server V9.0 docker image built using the Dockerfile and instructions in this repository to a Kubernetes cluster using a persistent volume for the Portal profile.

### Assumptions:

[IBM Cloud CLI](https://console.bluemix.net/docs/cli/reference/bluemix_cli/get_started.html#getting-started), the [IBM Cloud Container Service](https://console.bluemix.net/docs/containers/container_cli_cfic.html) plug-in, and [Kubernetes CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl) are installed. All services are logged into and initiated

### NOTE: The yaml files in this github repository were tested on Kubernetes version 1.8.6.
### Upload Image to IBM Cloud Container Registry:

Tag the expanded WebSphere Portal Server or Web Content Manager V9.0 docker image locally to reference your IBM Cloud Container space and push it to your IBM Cloud repository. You can locate the required value on your IBM Cloud Dashboard under the 'Cloud Foundry Space' heading.

```
docker tag dxen:v90 <registry.domain.bluemix.net>/<myCloudFoundrySpace>/dxen:v90
```

```
docker push <registry.domain.bluemix.net>/<myCloudFoundrySpace>/dxen:v90
```

### Create the Kubernetes cluster:

Create your [Kubernetes cluster](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_cluster_ui).  It is recommended that you choose a 4 Core CPU server with one Kubernetes worker node at a minimum.

### Deploy WebSphere Portal Server or Web Content Manager V9.0 to the cluster:

Edit the PortalDeployment.yml file so that the image value contains your IBM Cloud Foundry Space.  Replace \<CloudFoundrySpace\> with your Cloud Foundry Space value.

For example:

Change
```
- image: <registry.domain.bluemix.net>/<CloudFoundrySpace>/dxen:v90
```
to
```
- image: <registry.domain.bluemix.net>/<CloudFoundrySpace>/dxen:v90
```

Follow the instructions for [Deploying apps with the GUI](https://console.bluemix.net/docs/containers/cs_app.html#app_ui) using the yaml files provided in this repository.  

Upload the yamls in the following order one file at a time:

```
PersistentVolumeClaim.yml

PortalDeployment.yml

Services.yml
```

The Kubernetes Dashboard on IBM Cloud for your deployment should look similar to the following when deployment completes:

![dashboard](https://media.github.ibm.com/user/9496/files/945cfcd0-d523-11e7-82d4-d6ba370b5599)

Go to External Endpoints, in the Services category, and select the IP link with port 30005.   Your browser launches and you can complete the URL to access the Welcome page for WebSphere Portal:  
```
https://<externalendpointIP>:30005/wps/portal
```

The same can be done for the WebSphere Integrated Solutions Console listening on port 30008.  Select the IP with port 30008 and complete the URL:
```
https://<externalendpointIP>:30008/ibm/console
```

## Transferring IBM WebSphere Portal V9.0 Docker container on IBM Cloud in a Kubernetes Cluster to IBM Db2 Hosted

As root, ssh to your Db2 Hosted Server using the information in your 'Welcome email' and change the root password as instructed in the [IBM Db2 Hosted User Guide](ftp://public.dhe.ibm.com/cloud/bluemix/hosted/db2hosted_1.2.0_en_userguide.pdf) p1.

Create your database administrator user per the [IBM Db2 Hosted User Guide](ftp://public.dhe.ibm.com/cloud/bluemix/hosted/db2hosted_1.2.0_en_userguide.pdf) p 5-6.  These will be the @user@ and @pwd@ values used to transfer the Portal database.

 ```
useradd <username>
passwd <username>
<password>
<password>
```

Per page 5 of the [IBM Db2 Hosted User Guide](ftp://public.dhe.ibm.com/cloud/bluemix/hosted/db2hosted_1.2.0_en_userguide.pdf) you need to grant SYSCTL authority to your administrator by adding <username> to g_sysctl group. In addition add <username> to g_sysadm group as db2set and dbm cfg commands fail without this step.

```
usermod -a -G g_sysctl <username>
usermod -a -G g_sysadm <username>
```

Confgure Db2 Hosted server to allow <username> to login using ssh per the [IBM Db2 Hosted User Guide](ftp://public.dhe.ibm.com/cloud/bluemix/hosted/db2hosted_1.2.0_en_userguide.pdf) p6.

```
vi /etc/ssh/sshd_config
AllowUsers root <username>

service sshd restart
```

Add db2inst1 db2profile line to .bash_profile file per the [IBM Db2 Hosted User Guide](ftp://public.dhe.ibm.com/cloud/bluemix/hosted/db2hosted_1.2.0_en_userguide.pdf) p6.

```
vi /home/<username>/.bash_profile
type . /home/db2inst1/sqllib/db2profile as last line in file
```

Create the required Portal user groups

```
groupadd WP_BASE_CONFIG_USERS
groupadd WP_JCR_CONFIG_USERS
groupadd WP_PZN_CONFIG_USERS
```

At this point we assume the DX.Kubernets.IBM-Cloud repository has been cloned.

Edit the SetupDB2Database.sql, CreateDB2Database, DatabaseTransfer.sh, and DatabaseTransfer.properties scripts from the DX.Kubernetes.IBM-Cloud repository.

For example:

REPLACE all instances of @user@ and @pwd@ in SetupDB2Database.sql & CreateDB2Database with <username> and <password>
REPLACE all instances of @pwd@ in DatabaseTransfer.sh with <password>
REPLACE all instances of @user@ and @dbhost@ in DatabaseTransfer.properties with <username> and IP of your DB2 Hosted Server

Create an archive that contains the BackupPropertyFiles.sh, ConfigureDb2ForLargeFileHandling.sh, DatabaseTransfer.sh, DatabaseTransfer.properties, db2jcc4.jar and db2jcc_license_cu.jar files.

```
tar -czf scripts.tar.gz ./BackupPropertyFiles.sh ./ConfigureDb2ForLargeFileHandling.sh ./DatabaseTransfer.sh ./DatabaseTransfer.properties ,/db2jcc4.jar, db2jcc_license_cu.jar
```

Copy CreateDB2Database and SetupDB2Database.sql to your Db2 Hosted server connecting as <username>
** First connection type yes to accept authenticity**

```
scp ./CreateDB2Database <username>@dbhost@:/home/<username>
scp ./SetupDB2Database.sql <username>@dbhost@:/home/<username>
```

ssh to your Db2Hosted server as <username> and modify permissions of the copied scripts to allow execution.

```
chmod +x CreateDB2Database SetupDB2Database.sql
```

Type the following:

```
db2set DB2_COMPATIBILITY_VECTOR=0
```
This sets Varchar2 Compatibility to OFF which is required for transfer of the JCR database to succeed.

Run the CreateDB2Database script

```
./CreateDB2Database
```

Run the SetupDB2Database.sql script

```
db2 -svtf SetupDB2Database.sql
```

Restart DB2

```
db2stop
db2start
```

Copy the scripts archive (created in step #9 above) to your Kubernetes pod running Portal.

```
kubectl cp <repository-directory>/scripts.tar.gz <your-namespace>/<[portal-deployment]-[pod name]>:/root/
```

Open a shell into your Kubernetes pod running Portal

```
kubectl exec -it <pod-name> /bin/bash
```

Create a directory under wp_profile which will hold the Db2 library jars

```
mkdir -p /opt/IBM/WebSphere/wp_profile/db2/v11.1/java
```

Modify permissions to allow execution of the scripts.tar.gz file and unzip

```
cd /root/
chmod +x ./scripts.tar.gz
tar -xf ./scripts.tar.gz
```

Modify permissions to allow execution of the extracted script files

```
chmod +x ./BackupPropertyFiles.sh ./ConfigureDb2ForLargeFileHandling.sh ./DatabaseTransfer.sh ./DatabaseTransfer.properties
```

Copy the Db2 library jars to the location created in step #18 above.

```
cp ./db2jcc4.jar /opt/IBM/WebSphere/wp_profile/db2/v11.1/java
cp ./db2jcc_license_cu.jar /opt/IBM/WebSphere/wp_profile/db2/v11.1/java
```

Run the BackupPropertyFiles.sh script

```
./BackupPropertyFiles.sh
```

Run the DatabaseTransfer.sh script

```
./DatabaseTransfer.sh
```

Run the ConfigureDb2ForLargeFileHandling.sh script

```
./ConfigureDb2ForLargeFileHandling.sh
```

Start PortalServer

```
/opt/IBM/WebSphere/wp_profile/bin/./startServer.sh WebSphere_Portal
```

Portal is now using DB2 Hosted.


These processes have been tested and verified by IBM engineering and should produce consistent results when deployed to IBM Cloud and Kubernetes clusters.

Stay up to date on the latest information and technical guidance related to deploying IBM Digital Experience WebSphere Portal and Web Content Manager V9 docker files on IBM Cloud in Kubernetes clusters. Go to the IBM Digital Experience Developer Center at https://developer.ibm.com/digexp/.
