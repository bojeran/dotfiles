# Windows Unattended Installation

Best way to install windows 10
 - New folder `C:\IMG\` (folder name and location doesn't matter)

 - Mount `windows10.iso` and copy `../source/install.wim` to `C:\IMG\`

 - You might have a `install.wim` file which contains multiple windows versions
   (multiple separate wim files).

 - Extract version you like to install:

        dism /Get-WimInfo /WimFile:C:\IMG\install.wim

        dism /export-image /SourceImageFile:C:\IMG\install.wim /SourceIndex:5 /DestinationImageFile:C:\IMG\install-edu10n.wim /Compress:max /CheckIntegrity

 - Download and Install AIK for Windows 7
 - Prepare USB Stick (Cmd-Admin):

            diskpart
            list disk
            select USBSTICKNUMBER
            clean
            create partition primary
            format fs=ntfs quick
            active
            exit


 - copy `C:\Program Files\Windows AIK\Tools\amd64\imagex.exe` to `C:\IMG\`

 - Cmd-Admin (Usbstick Letter f:):
   (you might have to apply a letter to your drive with the partition manager)

        cd IMG
        imagex.exe /apply install.wim 1 f:\

        bcdboot.exe f:\windows /s f: /f ALL

 - Optionally you can also automate the privacy answers at the first startup of windows.
   (Not sure how, probably with ADK (Windows Assessment and Deployment Kit))



# Windows Setup

- Install chocolatey (https://chocolatey.org/install)
  - Install OpenSSL
  - Install pyenv for python development
  - Install nvm for javascript development
  - Install vim, git and other things you like


- Disable all App Execution aliases under: Apps & Features > App execution aliases.


- Uninstall optional features under: Apps & Features > Optional Features.
  

- Go to `https://privacy.sexy` - select what you like and apply to your system.
  - Webcam might not work problem:
    - You might want to let the Webcam usage enabled in the windows privacy settings
      otherwise you might have to enable&disable this setting everytime you want
      to use a Webcam
  - Windows Defender disablement additional step:
    - open Task Scheduler (german. Aufgabenplanung)
    - Go To (german): Aufgabenplanungsbibliothek/Microsoft/Windows/Windows Defender
    - Right click and press deactivate on all planned tasks.


- Setup WSL2 with latest Ubuntu LTS


- Setup Docker for Windows (available in WSL2)


- Save Space (if applicable):
  - Change Steam Default Installation Directory
  - Change UPlay Default Installation directory
  - Change Battle.net Default Installation Directory
  - Change Creative Cloud Default Installation Directory
  - Change ICloud Directory Location (Use Symlink trick)
  - Change Dropbox Directory Location
  - OBS Recording Location  
  - **Change location for new content**:
    - Press "Win + i" > System > Storage > 
      change location for new content
      

- Configure Services
  - Exclude folders from Windows search (Sandboxed Folders, etc.)
  - Defragmentation Service: Windows-Search "Defrag" and optionally 
    disable automatic Optimization
  - https://www.tomshardware.com/reviews/ssd-performance-tweak,2911-5.html
  - Stop Windows Event Logging (how?)

- Tools 
  - Sandboxie-Plus
  - Processexplorer
  - Autoruns (Sysinternals) (by Microsoft)
    - Make sure it's the latest version
    - Under "Everything" uncheck everything you don't need! Consider to make some 
      changes in the actual application instead of unchecking.
    - You can repeat this process after every installation.
  - Simplewall (Alternative: Tinywall (but little worse))
  
 
- For common Windows privacy concerns check out: [privacy.md](privacy.md).



# Disk setup

- Encrypt the system disk with e.g. Veracrypt.

- Non-system disks can be in EXT4 format
  - WSL2 can mount EXT4 disks (not single partitions?!)

      wmic diskdrive list brief
      wsl --mount [DiskPath]
      e.g. wsl --mount \\.\PHYSICALDRIVE0
      e.g. wsl --mount \\.\PHYSCIALDRIVE0 --partition 1

      wsl --unmount [DiskPath]

  - The disk should be now visible under /wsl/[mountpoint]
    and ALSO in the explorer somewhere.




