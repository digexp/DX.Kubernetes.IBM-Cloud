###########################################################################
# (C) Copyright IBM Corporation 2017.                                     #
#                                                                         #
# Licensed under the Apache License, Version 2.0 (the "License");         #
# you may not use this file except in compliance with the License.        #
# You may obtain a copy of the License at                                 #
#                                                                         #
#      http://www.apache.org/licenses/LICENSE-2.0                         #
#                                                                         #
# Unless required by applicable law or agreed to in writing, software     #
# distributed under the License is distributed on an "AS IS" BASIS,       #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.#
# See the License for the specific language governing permissions and     #
# limitations under the License.                                          #
###########################################################################

FROM portal:v90

RUN /opt/IBM/WebSphere/wp_profile/ConfigEngine/./ConfigEngine.sh modify-ports-by-startport \
	-DWasPassword=wpsadmin -DModifyPortsServer=WebSphere_Portal -DStartPort=30001	
	
COPY ./checkProfile.sh /root/

RUN mkdir -p /mnt/storage/wp_profile && \
  cp -a /opt/IBM/WebSphere/wp_profile/. /mnt/storage/wp_profile && \
  chmod +x /root/checkProfile.sh	

EXPOSE 30001 30005 30006 30008 30009 30010 30011 30012 30015 30017 30020 10200 10202 10203

CMD /root/./checkProfile.sh && /opt/IBM/WebSphere/wp_profile/bin/./startServer.sh WebSphere_Portal && tail -f /dev/null
