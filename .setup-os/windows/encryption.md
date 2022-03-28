
# Encryption

Encryption is another difficult problem to solve with good quality. I feel like
that most people just trust solutions because there is a big lack of
knowledge which can't be compensated easily.


# Disk Encryption

There are some rules you might agree on:
 - The Encryption solution should be completely OpenSource.
   You might still have to trust the lower layers
   of your system which might be proprietary.
 - There are some theoretical scenarios you might want to think about:
   - **loss of Hardware by law**: What you are trying to do can be considered Anti-Forensic which
     is kinda a complex topic as some of those guys are smart and inventive.
     When your computer is still running - disk encryption is usually not enough
     to protect your computer as your memory in your system is usually
     unencrypted and holds enough data to overcome disk encryption.
     If they want to make sure that you cannot trigger a dead man switch they might be able to
     e.g. by first catching you outside your house while the computer is running.
   - **loss of Hardware by theft**: When you consider the guy who is stealing your Hardware has
     access to the same tools then law enforcement then it's the same story.
     Some might consider this very unlikely.
     The most likely scenario is probably that the thief wants to make money
     or use the device itself. In this case you might want a lot of things:
      - find out who stole it 
      - where your device is currently located at
      - protect your data from being stolen as well
      - protect your data from being overwritten (so when you get your
        device back you still have all your data)
   - **Hardware is still running**: Someone spots that your computer is running, but you are not
     nearby.
   - **data exfiltration**: 
   - **post data exfiltration**:



# Disk Encryption Writeup

When looking for an Open Source disk encryption solution you might come
across following choices:
 - VeraCrypt: 
   - **Source Code**: https://github.com/veracrypt/VeraCrypt
     - Can be considered in **active development** (looked at in Nov. 2021)
   - **Security Analysis**: A lot of resources are available including a
     prominent one:
     https://www.bsi.bund.de/SharedDocs/Downloads/EN/BSI/Publications/Studies/Veracrypt/Veracrypt.pdf?__blob=publicationFile&v=1
     - Are problems found addressed in the current Veracrypt version?
   - **Conclusion after reading some research papers**
     - **TODO**
- DiskCryptor:
  - **Source Code**: https://github.com/DavidXanatos/DiskCryptor
    - Not sure if really actively developed. Last Update longer then half a
      year ago.
  - **Security Analysis**: Is mentioned in some research papers. 
    Seems less prominent than VeraCrypt.
  - **Conclusion after reading some research papers**
    - **TODO**
   
