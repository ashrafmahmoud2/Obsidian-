# Obsidian Auto Push Script

This repository contains a PowerShell script to automate pushing updates from an Obsidian vault to GitHub.

## Requirements
1. Git installed and configured on your system.
2. An existing Obsidian vault located at `D:\main .obsidian file`.     
3. A linked GitHub repository: [https://github.com/ashrafmahmoud2/Obsidian-.git](https://github.com/ashrafmahmoud2/Obsidian-.git).

## Script Overview
The script `AutoPushObsidian.ps1` automates the following tasks:
1. Staging all changes in the Obsidian vault.
2. Committing changes with a timestamped message.
3. Pushing updates to the `main` branch of the GitHub repository.

## Automation with Task Scheduler
To run this script automatically:
1. Open Task Scheduler (`Win + R`, type `taskschd.msc`, press Enter).
2. Create a task with the following configurations:
   - **Action**: "Start a Program".
   - **Program/script**: `powershell.exe`.
   - **Arguments**: 
     ```plaintext
     -ExecutionPolicy Bypass -File "D:\path\to\AutoPushObsidian.ps1"
     ```
3. Set the trigger to run at desired intervals (e.g., hourly, daily).

## Usage
1. Place the `AutoPushObsidian.ps1` script in a directory of your choice.
2. Update the `$vaultPath` variable in the script to the location of your Obsidian vault.
3. Run the script manually or automate it with Task Scheduler.

## Notes
- Ensure your GitHub credentials are cached or use SSH for authentication.
- Adjust the `ExecutionPolicy` setting if needed for your environment.
