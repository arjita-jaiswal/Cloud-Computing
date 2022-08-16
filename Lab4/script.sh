sudo apt update
sudo apt install -y apache2
sudo ufw allow 'Apache'
sudo apt install -y awscli
sudo apt-get install php -y
sudo aws s3 cp s3://arjitajaiswal f1 --recursive
sudo cp f1 var/www/html --recursive