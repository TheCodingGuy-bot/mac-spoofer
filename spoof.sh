
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
    rm -rf ~/Library/Application\ Support/[AppName]
    rm -rf ~/Library/Preferences/com.[company].[app].plist
    echo 'cleared cache'
    echo 'changing UUID and GUID'
    echo "== macOS User ID Modifier =="

    # Ask for the username
    read -p "Enter the username of the account to modify: " user
    # Check if user exists
    if ! id "$user" &>/dev/null; then
        echo "❌ User '$user' does not exist."
        exit 1
    fi
    # Generate safe random UniqueID and PrimaryGroupID
    unique_id=$((RANDOM % 1000 + 1000))      # UID: 1000–1999
    primary_group_id=$((RANDOM % 100 + 20))  # GID: 20–119
    echo "Generated UniqueID: $unique_id"
    echo "Generated PrimaryGroupID: $primary_group_id"
    # Confirm before proceeding
    read -p "Apply these changes to user '$user'? (y/n): " confirm
    if [[ "$confirm" != "y" ]]; then
        echo "Operation cancelled."
        exit 0
    fi
    # Change ownership of home folder
    sudo chown -R "$user":"$user" "/Users/$user"
    # Change UID and GID via dscl
    sudo dscl . -create /Users/"$user" UniqueID $unique_id
    sudo dscl . -create /Users/"$user" PrimaryGroupID $primary_group_id
    echo "✅ Updated UID and GID for user '$user'."
