#/bin/sh
if ((EUID != 0)); then
  echo >&2 "Shinobi requires that it be run as root because PM2 is used to manage the processes. Exiting..."
  exit 1
fi
apt update
apt install git -y
cd /home
echo "Install the Development branch?"
echo "(y)es or (N)o"
read theBranchChoice
if [ "$theBranchChoice" = "Y" ] || [ "$theBranchChoice" = "y" ]; then
    echo "Getting the Development Branch"
    theBranch='dev'
else
    echo "Getting the Grand Master Branch"
    theBranch='master'
fi
git clone https://github.com/ShinobiCCTV/Shinobi.git -b $theBranch
cd Shinobi
chmod +x INSTALL/start.sh
INSTALL/start.sh