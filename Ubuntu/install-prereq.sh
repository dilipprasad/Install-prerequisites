#!/bin/bash
ERROR_FILE="/tmp/install-prereq.sh.error"


# Check if the script is being run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Please use sudo."
   exit 1
fi


# Update the package index
echo "Updating packages"
sudo apt update


echo "**************************************"
echo "Installing docker"

# Install Docker's dependencies
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker's stable repository
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


# Update the package index again
sudo apt update

# Install Docker
Y | sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "End of docker installation"
echo "**************************************"

echo "Installing portainer"
docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer
echo "End of portainer installation"

echo "**************************************"







echo "**************************************"







echo "**************************************"



# did everything finish correctly? Then we can exit
echo "Installation complete"
exit 0