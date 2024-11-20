# Manage Hosts Script

A simple Bash script to toggle between "Local" and "Prod" environments by commenting or uncommenting a specific block in your `/etc/hosts` file. Designed for developers who frequently switch environments.

## Features

- Automatically detects if the `/etc/hosts` block is in "Local" (commented) or "Prod" (uncommented) mode.
- Toggles between the two modes with a simple Y/N prompt.
- Creates a backup of `/etc/hosts` as `/etc/hosts.bak` before making changes.
- User-friendly, colorful prompts for clarity.

## Installation

1. Clone this repository or copy the `manage_hosts.sh` script to a directory on your system:

   ```
   mkdir -p ~/Scripts
   cp manage_hosts.sh ~/Scripts/
   ```

2. Make the script executable:

   ```
   chmod +x ~/Scripts/manage_hosts.sh
   ```

3. Add the script's directory to your PATH for easy access:

   Open your shell configuration file (`~/.zshrc` for Zsh, or `~/.bash_profile` for Bash) in an editor:

   ```
   nano ~/.zshrc
   ```

   Add the following line to the file:

   ```
   export PATH="$HOME/Scripts:$PATH"
   ```

   Save and close the file by pressing `CTRL + O`, then `CTRL + X`.

4. Reload your shell configuration to apply the changes:

   ```
   source ~/.zshrc
   ```

## Usage

To run the script, simply type:

```
manage_hosts.sh
```

The script will detect the current mode and prompt you to switch between "Local" and "Prod":

- Enter `Y` to toggle between "Local" and "Prod" modes.
- Enter `N` to leave the `/etc/hosts` file unchanged.

## Notes

- The script requires `sudo` privileges to modify `/etc/hosts`.
- A backup of the original `/etc/hosts` file is created as `/etc/hosts.bak` before changes are applied.
