USER=$1
KEY=$2

adduser --disabled-password $USER
mkdir /home/$USER/.ssh
echo $KEY > /home/$USER/.ssh/authorized_keys
chown -R $USER: /home/$USER/.ssh
chmod 0700 /home/$USER/.ssh
chmod 0600 /home/$USER/.ssh/authorized_keys
echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-$USER
