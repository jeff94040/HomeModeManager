## Home Mode Manager

Home Mode Manager is a bash script running inside a Docker container that 1) detects mobile phone presence on a home network and 2) toggles the "Home Mode" setting on Synology's Surveillance Station application. The script prevents the need to enable location tracking on your mobile device 24x7, therefore significantly extending its battery life while away from the house. When a mobile phone is detected on the home network (i.e. somebody is home), "Home Mode" is enabled, and push notifications will not be sent when surveillance cameras detect motion. When a mobile phone is NOT detected on the home network (i.e. nobody is home), "Home Mode" is disabled, and push notifications will be sent when surveillance cameras detect motion. 

### Prerequisites

1. Docker
2. Git

### Install the script

%> git clone <repo>

### Script Usage

%> ./docker_run_command.sh