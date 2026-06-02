#!/bin/bash 

# Function to display messages in colored text
function print_message() {
  COLOR='\033[1;32m'
  NC='\033[0m' # No Color
  echo -e "${COLOR}$1${NC}"
}

# Step 1: Set up GitHub authorization with Personal Access Token
print_message "Step 1: Authorizing GitHub with a Personal Access Token (PAT)"

# Prompt for GitHub PAT
read -s -p "Enter your GitHub Personal Access Token (PAT): " GITHUB_PAT
echo ""

# Store GitHub credentials permanently in the Git credentials store
git config --global credential.helper store

# Add the credentials to the Git credentials file
CREDENTIALS_FILE=~/.dotfiles/git-github/.git-credentials
GITHUB_URL="https://$GITHUB_PAT@github.com"

# Check if the credentials file exists, if not, create it
if [ ! -f "$CREDENTIALS_FILE" ]; then
  touch "$CREDENTIALS_FILE"

  # Add or update the GitHub credentials
  grep -q "$GITHUB_URL" "$CREDENTIALS_FILE" || echo "$GITHUB_URL" >> "$CREDENTIALS_FILE"
fi

print_message "Git and GitHub have been configured successfully!"

# Step 3: Verify Git configuration
print_message "Step 3: Verifying Git configuration"
git config --global --list

print_message "Setup complete!"
