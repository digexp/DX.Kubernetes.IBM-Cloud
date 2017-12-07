# Digital Experience on IBM Cloud in a Kubernetes Cluster
IBM WebSphere Portal V9.0 Docker container running on IBM Cloud in a Kubernetes Cluster

For more information on IBM Cloud and Kubernetes please reference: Getting started with IBM Cloud Container Service 
https://console.bluemix.net/docs/containers/container_index.html#container_index

The contents of this directory may be used to extend an image of IBM WebSphere Portal or Web Content Manager that were created using the Dockerfile scripts posted at the [IBM WebSphere Portal Server and Web Content Manager V9.0 Git Repository](https://github.com/digexp/ci.docker.websphere-portal)  The extended image will start the WebSphere_Portal server when the container is started using ports configured for access when running in a Kubernetes pod on IBM Cloud.

* Step 1:  Start the existing IBM WebSphere Portal or Web Content Manager V9.0 image and build a new image using the Dockerfile above and instructions in this readme.
	
* Step 2:  Deploy the extended IBM WebSphere Portal or Web Content Manager V9.0 image to Kubernetes using the YAML files above and instructions in this readme.
	
******************************************************************	
	
The following instructions can be used to extend an existing IBM WebSphere Portal Server or Web Content Manager V9.0 docker image running on CentOS7 previously built using instructions at this [repository](https://github.com/digexp/ci.docker.websphere-portal).  

### Assumptions:

Pre-requisites for the existing [WebSphere Portal Server](https://github.com/digexp/ci.docker.websphere-portal/tree/master/IBMWebSpherePortalServerV9.0), [Web Content Manager](https://github.com/digexp/ci.docker.websphere-portal/tree/master/IBMWebContentManagerV9.0), or WebSphere Portal Server and Web Content Manager (with [Enable](https://github.com/digexp/ci.docker.websphere-portal/tree/master/IBMWebSpherePortalEnableV9.0), [Extend](https://github.com/digexp/ci.docker.websphere-portal/tree/master/IBMWebSpherePortalExtendV9.0)) V9.0 image have been met.

### Building the IBM WebSphere Portal Server or Web Content Manager V9.0 image

#### Clone this repository
Use git or github to clone this repository.

#### Build the extended IBM WebSphere Portal Server or Web Content Manager V9.0 docker image

Run the following command in a new command/terminal window to build the new docker image:

```
docker build -t dxen:v90 .
```

* This command should take around 5 minutes to complete.

The `dxen:v90` image is a fully functional single node WebSphere Portal or Web Content Manager V9.0 with ports configured for deployment to a Kubernetes cluster on a WebSphere Application Server V9.0 installation using Derby.  

******************************************************************

### DEPLOYMENT TO KUBERNETES in IBM CLOUD:  

The following instructions can be used to deploy the extended IBM WebSphere Portal Server V9.0 docker image built using the Dockerfile and instructions in this repository to a Kubernetes cluster using a persistent volume for the Portal profile.

### Assumptions:

[IBM Cloud CLI](https://console.bluemix.net/docs/cli/reference/bluemix_cli/get_started.html#getting-started), the [IBM Cloud Container Service](https://console.bluemix.net/docs/containers/container_cli_cfic.html) plugin and [Kubernetes CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl) are installed.  All are logged into and initiated.

### Upload Image to IBM Cloud Container Registry:

Tag the expanded IBM WebSphere Portal Server or Web Content Manager V9.0 docker image locally to reference your IBM Cloud Container space and push it to your IBM Cloud repository. You can locate the required value on your IBM Cloud Dashboard under the 'Cloud Foundry Space' heading.

```
docker tag dxen:v90 registry.ng.bluemix.net/<myCloudFoundrySpace>/dxen:v90
```

```
docker push registry.ng.bluemix.net/<myCloudFoundrySpace>/dxen:v90
```

### Create the Kubernetes cluster:

Create your [Kubernetes cluster](https://console.bluemix.net/docs/containers/cs_cluster.html#cs_cluster_ui).  It is recommended that you choose a 16 Core CPU machine with one Kubernetes worker node at a minimum.

### Deploy IBM WebSphere Portal Server or Web Content Manager V9.0 to the cluster:

Edit the PortalDeployment.yml file so that the image value contains your IBM Cloud Foundry Space.  Replace \<CloudFoundrySpace\> with your Cloud Foundry Space value.

For example:
```
Change 
- image: registry.ng.bluemix.net/<CloudFoundrySpace>/dxen:v90

to
- image: registry.ng.bluemix.net/myCloudFoundrySpace/dxen:v90
```

Follow the instructions for [Deploying apps with the GUI](https://console.bluemix.net/docs/containers/cs_apps.html#cs_apps_ui) using the yaml files provided in this repository.  

Upload the yamls in the following order:

```
PersistentVolumeClaim.yml

PortalDeployment.yml

Services.yml
```

The Kubernetes Dashboard on IBM Cloud for your deployment should look similar to the following when deployment completes:

![dashboard](https://media.github.ibm.com/user/9496/files/945cfcd0-d523-11e7-82d4-d6ba370b5599)

Under External Endpoints, in the Services category, select the IP link with port 30005.   Your browser will launch and you can complete the URL to access the Welcome page for WebSphere Portal as follows:  
```
https://<externalendpointIP>:30005/wps/portal 
```

The same can be done for the WebSphere administration console listening on port 30008.  Select the IP with port 30008 and complete the URL:
```
https://<externalendpointIP>:30008/ibm/console
```
These processes have been tested and verified by IBM engineering and should produce consistent results when deployed to IBM Cloud and Kubernetes clusters.

Stay up to date on the latest information and technical guidance related to deploying IBM Digital Experience WebSphere Portal and Web Content Manager V9 docker files on IBM Cloud in Kubernetes clusters please visit the IBM Digital Experience Developer Center at https://developer.ibm.com/digexp/.
