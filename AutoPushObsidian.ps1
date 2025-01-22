# Define the path to the Obsidian vault
$vaultPath = "D:\main .obsidian file"

# Navigate to the vault directory
Set-Location -Path $vaultPath

# Stage all changes
git add .

# Commit changes with a timestamped message
$commitMessage = "Auto-update $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git commit -m $commitMessage

# Push changes to the GitHub repository
git push origin main
