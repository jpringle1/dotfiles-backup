#!/bin/bash 

CREDENTIALS_FILE="$HOME/.dotfiles/smbcredentials/.smbcredentials"
SMB_USERNAME="joep"

# Function to display a success message
function print_message() {
  COLOR='\033[1;32m'
  NC='\033[0m' # No Color
  echo -e "${COLOR}$1${NC}"
}

# Check if the credentials file already exists
if [ -f "$CREDENTIALS_FILE" ]; then
  echo "Warning: The credentials file '$CREDENTIALS_FILE' already exists."
  read -p "Do you want to overwrite it? (y/n): " overwrite
  if [[ "$overwrite" != "y" ]]; then
    echo "Operation cancelled."
    exit 1
  fi
else
  touch "$CREDENTIALS_FILE"
fi

# Prompt for SMB password (hidden input)
read -s -p "Enter your SMB password: " SMB_PASSWORD
echo ""

# Create or overwrite the .smbcredentials file
echo "username=$SMB_USERNAME" > "$CREDENTIALS_FILE"
echo "password=$SMB_PASSWORD" >> "$CREDENTIALS_FILE"

# Secure the .smbcredentials file by restricting access
chmod 600 "$CREDENTIALS_FILE"

# Success message
print_message "The SMB credentials file '$CREDENTIALS_FILE' has been created and secured."
