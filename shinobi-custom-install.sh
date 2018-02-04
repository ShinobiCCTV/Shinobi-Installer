#! /bin/sh
echo "---------------------------------------------"
echo "Install Location for Shinobi"
echo '*Note : Default install location is "/home"'
echo "Do you want to install a custom location for Shinobi?"
echo "(y)es or (N)o? Default : No"
    read installLocationChoice
    if [ "$installLocationChoice" = "Y" ] || [ "$installLocationChoice" = "y" ]; then
        echo "Example : /home"
        read installLocation
    else
        installLocation='/home'
    fi
cd $installLocation
echo "Opening Install Location : \"$installLocation\""
if [ ! -d "Shinobi" ]; then
    # Check OS
    case "$(uname -s)" in
       Darwin)
       # Mac OS
         OSTYPE='darwin'
         ;;
       Linux)
       # Ubuntu, CentOS
         OSTYPE='linux'
         ;;
    esac
    # Check if Mac OS and if Git is needed
    if [ "$OSTYPE" = "darwin"* ] && [ ! -x "$(command -v git)" ]; then
        if [ ! -x "$(command -v brew)" ]; then
            ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            brew doctor
        fi
        brew install git
    else
        # Check if user is root
        if [ "$(id -u)" != 0 ]; then
            echo "*--------------------**---------------------*"
            echo "*Shinobi requires being run as root."
            echo "*Do you want to continue without being root?"
            echo "(Y)es or (n)o? Default : Yes"
            read nonRootUser
            if [  "$nonRootUser" = "N" ] || [  "$nonRootUser" = "n" ]; then
                echo "Stopping..."
                exit 1
            fi
        fi
        # Check if Git is needed
        if [ ! -x "$(command -v git)" ]; then
            # Check if Ubuntu
            if [ -x "$(command -v apt)" ]; then
                sudo apt update
                sudo apt install git -y
            fi
            # Check if Cent OS
            if [ -x "$(command -v yum)" ]; then
                sudo yum update
                sudo yum install git -y
            fi
        fi
    fi
    echo "*--------------------**---------------------*"
    echo "Install Shinobi CE or Shinobi Pro?"
    echo "---------------------------------------------"
    echo "*Note : Shinobi Pro is free for personal use."
    echo "*Learn more at http://shinobi.video/pro"
    echo "---------------------------------------------"
    echo "(C)E or (P)ro? Default : Pro"
    read theRepoChoice
    if [ "$theRepoChoice" = "custom" ]; then
        echo "Input Custom Shinobi Repo URL"
        echo "Example : https://github.com/ShinobiCCTV/Shinobi"
        read gitURL
        echo "Input Branch. Press [ENTER] to use Master."
        read theBranch
        if [ "$theBranch" = "" ]; then
            theBranch='master'
        fi
    else
        if [ "$theRepoChoice" = "C" ] || [ "$theRepoChoice" = "c" ] || [ "$theRepoChoice" = "CE" ] || [ "$theRepoChoice" = "ce" ]; then
            productName="Shinobi Community Editon (CE)"
            theRepo='moeiscool'
            theBranch='master'
        else
            theRepo='ShinobiCCTV'
            productName="Shinobi Professional (Pro)"
            echo "Install the Development branch?"
            echo "(y)es or (N)o? Default : No"
            read theBranchChoice
            if [ "$theBranchChoice" = "Y" ] || [ "$theBranchChoice" = "y" ]; then
                echo "Getting the Development Branch"
                theBranch='dev'
            else
                echo "Getting the Master Branch"
                theBranch='master'
            fi
        fi
        gitURL="https://github.com/$theRepo/Shinobi"
    fi
    # Download from Git repository
    sudo git clone $gitURL.git -b $theBranch
    # Enter Shinobi folder "/home/Shinobi"
    cd Shinobi
    gitVersionNumber=$(git rev-parse HEAD)
    theDateRightNow=$(date)
    # write the version.json file for the main app to use
    sudo touch version.json
    sudo chmod 777 version.json
    sudo echo '{"Product" : "'"$productName"'" , "Branch" : "'"$theBranch"'" , "Version" : "'"$gitVersionNumber"'" , "Date" : "'"$theDateRightNow"'" , "Repository" : "'"$gitURL"'"}' > version.json
    echo "-------------------------------------"
    echo "---------- Shinobi Systems ----------"
    echo "Repository : $gitURL"
    echo "Product : $productName"
    echo "Branch : $theBranch"
    echo "Version : $gitVersionNumber"
    echo "Date : $theDateRightNow"
    echo "-------------------------------------"
    echo "-------------------------------------"
else
    echo "!-----------------------------------!"
    echo "Shinobi already downloaded."
    cd Shinobi
fi
# start the installer in the main app (or start shinobi if already installed)
echo "*-----------------------------------*"
sudo chmod +x INSTALL/start.sh
sudo INSTALL/start.sh