#remember to change permission of the file. 'chmod +x go_phish_launcher
#and then launch the script 'sudo ./go_phish_launsher.sh email'
EMAIL="$1"

# Validate email
if [ -z "$EMAIL" ]; then
  echo "Error: You need to run the script with an email."
  echo "Example: sudo ./go_phish_launcher.sh email_email@gmail.com"
  exit 1
fi
echo "Starting..."
echo "Installing go phish"
cd ~ || exit
mkdir "go_phish"
echo "Created folder on $(pwd)"
cd go_phish || exit
wget https://github.com/gophish/gophish/releases/download/v0.12.1/gophish-v0.12.1-linux-64bit.zip
sudo apt install unzip
unzip gophish-v0.12.1-linux-64bit.zip
sudo apt install openssl
read -n1 -r -p "We will create a SSL certificate. The only required field is the email. You can click on 'enter' in the rest of fields" key
openssl req -newkey rsa:2048 -nodes -keyout gophish.key -x509 -days 365 -out gophish.crt
sudo apt install jq -y
echo "Updating config.json..."
CERT_PATH="$(pwd)/gophish.crt"
KEY_PATH="$(pwd)/gophish.key"
jq --arg cert "$CERT_PATH" \
   --arg key "$KEY_PATH" \
   --arg email "$EMAIL" \
   '.admin_server.listen_url = "0.0.0.0:3333" |
    .admin_server.cert_path = $cert |
    .admin_server.key_path = $key |
    .phish_server.cert_path = $cert |
    .phish_server.key_path = $key |
    .contact_address = $email' \
    config.json > config_temp.json && mv config_temp.json config.json
echo "File config.json modified"
sudo chmod +x gophish
echo "Installing screen"
sudo apt install screen
echo "Starting screen called 'go_phish'"
screen -S go_phish
echo "Executing go_phish"
sudo ./gophish

echo "You can see all the screens with 'screen ls'"
echo "To change screen you can click Cntrl+A, D"
echo "To join gophish screen again, run 'screen -r go_phish'"
echo "Done. return regards;"