#! /bin/sh
if [ "$OSTYPE" == "darwin"* ] && [ ! -x "$(command -v git)" ]; then
    if [ ! -x "$(command -v brew)" ]; then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew doctor
    fi
    brew install git
else
    if ((EUID != 0)); then
      echo >&2 "Shinobi requires that it be run as root because PM2 is used to manage the processes. Exiting..."
      exit 1
    fi
    if [ ! -x "$(command -v git)" ]; then
        if [ -x "$(command -v apt)" ]; then
            apt update
            apt install git -y
        fi
        if [ -x "$(command -v yum)" ]; then
            yum update
            yum install git -y
        fi
    fi
fi
cd /home
echo "Install Shinobi CE or Shinobi Pro?"
echo "*Note : Shinobi Pro is free for personal use."
echo "*Learn more about Shinobi Pro at http://shinobi.video/pro"
echo "(C)E or (P)ro? Default : Pro"
read theRepoChoice
if [ "$theRepoChoice" = "C" ] || [ "$theRepoChoice" = "c" ] || [ "$theRepoChoice" = "CE" ] || [ "$theRepoChoice" = "ce" ]; then
    productName="Shinobi Community Editon (CE)"
    echo "-------------------------------------"
    theRepo='moeiscool'
    theBranch='master'
else
    theRepo='ShinobiCCTV'
    productName="Shinobi Professional (Pro)"
    echo "-------------------------------------"
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
fi
# Download from Git repository
git clone https://github.com/$theRepo/Shinobi.git -b $theBranch
# Enter Shinobi folder "/home/Shinobi"
cd Shinobi
# write version number
function getGitVersionNumber() {
  git rev-parse --short HEAD 2> /dev/null | sed "s/\(.*\)/@\1/"
}
gitVersionNumber=$(getGitVersionNumber)
theDateRightNow=$(date)
cat <<EOF > version.json
{"Product" : "$productName" , "Branch" : "$theBranch" , "Version" : "$gitVersionNumber" , "Date" : "$theDateRightNow" , "Repository" : "https://github.com/$theRepo/Shinobi"}
EOF
echo "-------------------------------------"
echo "---------- Shinobi Systems ----------"
echo "Repository : https://github.com/$theRepo/Shinobi"
echo "Product : $productName"
echo "Branch : $theBranch"
echo "Version : $gitVersionNumber"
echo "Date : $theDateRightNow"
echo "-------------------------------------"
echo "-------------------------------------"
chmod +x INSTALL/start.sh
INSTALL/start.sh