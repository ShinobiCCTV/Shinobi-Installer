#/bin/sh
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
echo "(C)E or (P)ro? Default : Pro"
read theRepoChoice
if [ "$theRepoChoice" = "C" ] || [ "$theRepoChoice" = "c" ]; then
    theRepo='ShinobiCCTV'
    theBranch='master'
else
    theRepo='ShinobiCCTV'
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
git clone https://github.com/$theRepo/Shinobi.git -b $theBranch
cd Shinobi
chmod +x INSTALL/start.sh
INSTALL/start.sh