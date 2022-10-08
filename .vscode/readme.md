### Getting the Synthwave '84 Glow to Work

EVERY TIME YOU UPDATE VSCODE you need to do the following to make the Glow work again:

#### Step 1: Enable Glow

a. On Arch Linux, you have to use the following terminal command

```
sudo chown -R neo /opt/visual-studio-code
```

b. Open VS code, and hit `Ctrl-Shift-P`, and execute command `Enable Neon Glow`
  
c. Restart VS code.
  
d. Go back to the terminal and revert the permissions back with:

```
sudo chown -R root /opt/visual-studio-code
```

#### Step 2: Deal with Error (your Code installation appears to be corrupt.  Please re-install)
(Install VS Code Extension called `Fix VSCode Checksums`

a. open the command palette and execute `Fix Checksums: Apply`.

b. You will need to completely restart VSCode after execution, reopening without fully exiting might not be enough.




