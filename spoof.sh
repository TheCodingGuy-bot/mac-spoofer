
    # Load nvm into current shell
    export NVM_DIR="$HOME/.nvm"
    source "$NVM_DIR/nvm.sh"

    # Install latest LTS Node.js
    echo "[+] Installing latest LTS version of Node.js..."
    nvm install --lts

    # Confirm installation
    echo "[+] Node version:"
    node -v

    echo 'if anything failed here install node js manually'
    npm install spoof -g
    sudo spoof randomize en0
    sudo spoof randomize en1

    echo 'Do not worry about the previous error'
    networksetup -setairportpower en0 off
    echo 'Turning internet off for a second, will be back on soon...'
    sudo spoof-mac randomize en0
    echo 'generating random mac adress'
    random1=$(( (RANDOM % 99) + 1 ))
    random2=$(( (RANDOM % 99) + 1 ))
    random3=$(( (RANDOM % 99) + 1 ))
    random4=$(( (RANDOM % 99) + 1 ))
    random5=$(( (RANDOM % 99) + 1 ))
    random6=$(( (RANDOM % 99) + 1 ))
    sudo spoof set $random1:$random2:$random3:$random4:$random5:$random6 en0
    networksetup -setairportpower en0 on
    echo 'generated a random mac address and turned the internet back on'


