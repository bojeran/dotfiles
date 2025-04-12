# Windows Installation Methods
Options:
- **Win10/11-ntlite-custom-image:** Use NTLITE to create a custom image, but you might have to live with no proper Windows Update and other problems.
- **Win10/11-diy-custom-image:** Install Windows; install/configure what you like and then capture the image with `Dism /Capture-Image /ImageFile:c:\IMG\install.wim /CaptureDir:C:\IMG /Name:ImgData`
- **Win10-run-on-usb-stick-method:** See below. Might not work properly with Win11.

# Win10 Run On USB Stick Method

A Rapid way of Windows 10 installation:
 - Optionally get NTLite and create your own Windows 10 Image.

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


 - copy `C:\Program Files\Windows AIK\Tools\amd64\imagex.exe` to `C:\IMG\` (not bcdboot.exe)

 - Cmd-Admin (Usbstick Letter f:):
   (you might have to apply a letter to your drive with the partition manager)

        cd IMG
        imagex.exe /apply install.wim 1 f:\

        bcdboot.exe f:\windows /s f: /f ALL

 - Optionally you can also automate the privacy answers at the first startup of windows.
   (Not sure how, probably with ADK (Windows Assessment and Deployment Kit))
 



# Windows Setup

- Explorer -> This PC -> Right-Click C: drive (and/or any other drive) -> General -> uncheck: Allow files on this drive to have contents indexed in addition to file properties

- Install simplewall
  - Import "default.xml" (previous configurations)
  - Configure manually

- Install firefox
  - optionally create a firefox profile: Win+R -> `firefox -P`
  - Run the `privacy.sexy` script for firefox
  - Configure manually


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

- **Disable Windows Defender**
  - The only sustainable and clean method to get rid of Windows Defender seems to be installing a fresh windows instance without it. Check out the ntlite based windows installation method.
  - The following will probably not work and in the end you might need a script which runs on every Windows start. But you can try.
  - Read about [Tamper Protection](
    https://docs.microsoft.com/en-us/microsoft-365/security/defender-endpoint/prevent-changes-to-security-settings-with-tamper-protection?view=o365-worldwide)
  - Go to Windows Security Settings and disable everything. Most importantly `Realtime Protection` and 
    `Tamper Protection`.
    - e.g.: Windows Security -> Virus & threat protection -> Virus & threat protection settings ->
      Manage settings -> Tamper Protection -> Off
  - (Other path) Not tried: `https://privacy.sexy` got you covered with some scripts you might need to execute.
  - Get [Microsoft Sysinternals PsTools](https://docs.microsoft.com/en-us/sysinternals/downloads/pstools)
    - needed to run things as SYSTEM user (being Administrator is not enough)
    - Example `.\PsExec64.exe -s -i -d cmd.exe`
    - Alternative: `https://www.nirsoft.net/utils/nircmd.html`
      - Unpacking might not work if you have Realtime Protection on
      - Example: `.\nircmd.exe elevatecmd runassystem cmd.exe`
  - Open Resource Monitor (perfmon.exe /res)
    - From Admin-Shell: `.\PsExec64.exe -s -i -d c:\windows\system32\perfmon.exe /res`
    - -> Overview -> Right click "MsMpEng.exe" and press suspend.
    - Warning: This step can cause windows to freeze if you did not disable all Options in the Windows Security Settings
  - Regedit Changes:
    - Admin-Shell: `.\PsExec64.exe -s -i -d c:\windows\regedit.exe`
    - set `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features\TamperProtection` to `0x00`
    - set `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features\TamperProtectionSource` to `0x00`
      - This step only works if tamper protection is already disabled via the System Settings before. So we tamper with the tamper protection settings now xD. (Tamper Protection protects the registry from being changed in certain places)
  - Task Schedular changes:
    - open Task Scheduler (german. Aufgabenplanung)
    - Go To (german): Aufgabenplanungsbibliothek/Microsoft/Windows/Windows Defender
    - Right click and press deactivate on all planned tasks.
  - Open Local Group Policy Editor
    - From Admin-Shell: `c:\windows\system32\gpedit.msc` (can not be run as SYSTEM user but Admin seems enough)
    - -> Computer Configuration > Administrative Templates > Windows Components > Microsoft Defender Antivirus 
      -> Enable Turn off Microsoft Defender Antivirus
  - Some steps that did not work (skip them):
    - (Does not work) So... we have to get rid of MsMpEng...
    - (This does not work) Disable the service, open admin shell and run
      - `.\PsExec64.exe -s -i -d %windir%\system32\services.msc` (does not work)
      - `.\PsExec64.exe -s -i -d C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe`
        - SYSTEM shell:
        
              Get-Service -Name WinDefend
              Stop-Service -Name WinDefend -force
              Set-Service -Name WinDefend -startupType disabled
              Get-Service -Name WinDefend | Select Name, Status, StartType
          
        - Does not work
    - (Does not work) So get [Microsoft Sysinternals Autoruns](https://docs.microsoft.com/en-us/sysinternals/downloads/autoruns)
      - Copy Autoruns64.exe into same folder then nircmd.exe
      - From Admin-Shell: `.\PsExec64.exe -s -i -d Autoruns64.exe`
      - Uncheck `Hide Windows Entries`
      - Search for `WinDefend`
      - Uncheck the Box next to `WinDefend`
      - We still cannot set `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend\Start` from 2 (Start)
        to 4 (Disabled).
  - Wait and restart the Local Group Policy Editor after a while and set the Turn Off Microsoft Defender Antivirus again
  - Restart the Computer
  - Ok now go to Windows Security and when you see Realtime Protection on and Tamper Protection on, then try
    to disable Tamper protection first. This should toggle Realtime Protection automatically.
  - Restart computer
  - `Tamper Protection off and Realtime Protection off` should be off now


- Setup WSL2 with latest Ubuntu LTS


- Setup Docker for Windows (available in WSL2)


- File Explorer Options -> General -> Privacy -> Uncheck: Show files from Office.com
- File Explorer Options -> General -> Open File Explorer to: This PC
- File Explorer Options -> View -> Check: Display the full path in the title bar.
- File Explorer Options -> View -> Uncheck: Hide folder merge conflicts
- File Explorer Options -> View -> Uncheck: Use Sharing Wizard


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
    - Search for `Searching Windows` -> `Advanced Search Indexer Settings` -> Remove folders
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


- If you use a QMK keyboard you might want to run the following in an elevated shell:
  `REG ADD HKCU\Software\Classes\ms-officeapp\Shell\Open\Command /t REG_SZ /d rundll32`
  (source: https://superuser.com/questions/1455857/how-to-disable-office-key-keyboard-shortcut-opening-office-app)


- Disable Windows path length limit (260 characters).

- Search: Computer Management -> Services and Applications: Set `Secondary Logon Startup Type` to automatic and start. (This allows you to right-click programs with shift to start programs as other user)

- Set password to never expire: Win+R -> `winplwiz` -> Advanced. User -> right-click user -> properties -> Check: Password never expires.

- Manually manage paging (this is swap): `Win + R` -> `sysdm.cpl` -> Advanced -> performance -> settings -> Advanced -> Change ... -> AFTER CHANGING YOU HAVE TO CLICK THE `SET` button.


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




