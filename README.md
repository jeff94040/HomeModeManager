## Home Mode Manager

Home Mode Manager is a bash script that 1) detects mobile phone presence on a home network and 2) toggles the "Home Mode" setting on Synology's Surveillance Station application. The script prevents the need to enable location tracking on your mobile device 24x7, therefore significantly extending its battery life while away from the house. When a mobile phone is detected on the home network (i.e. somebody is home), "Home Mode" is enabled, and push notifications will not be sent when surveillance cameras detect motion. When a mobile phone is NOT detected on the home network (i.e. nobody is home), "Home Mode" is disabled, and push notifications will be sent when surveillance cameras detect motion. 

### Install dependencies

1. sudo apt update
2. sudo apt install hping3
3. sudo apt install curl
4. sudo apt install jq
5. sudo apt install tzdata

### Clone the repo

%> git clone https://github.com/jeff94040/home_mode_manager.git

### Run the script

%> ./home_mode_manager.sh