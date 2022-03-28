
# Privacy Settings for Windows

Privacy on Windows is a complex topic.

Here some issues you might face:
 - **User experience**: Some settings might lead to user 
   experience inconveniences.
   E.g. turning of Application Webcam access leads to not working
   Webcams in Discord, Skype & so on, and you might not remember that
   the privacy settings caused it.
 - **Privacy over Security**: Some settings are putting your security at 
   risk. 
   E.g. when you disable Windows Defender and you do not have an 
   alternative running you loose virus detection for privacy.
 - **Missing Knowledge**: You might not understand the implication 
   or impact the setting will have.
   E.g. you disable a Windows Service and you don't know what it does
   OR you disable a feature (e.g. Superfetch) you don't know what it does.
   
 
From a developer point of view it's also complicated:
 - **Verification**: It is hard to verify if the setting you took also has
   any effect.
   e.g. When you disable Windows Defender, but you leave the Integrity
   Protection in Windows on. Windows Defender might start running again.
 - **Windows Update dilemma:**
   - Windows tends to reset settings you did
   - Windows Updates might change the way how you disable settings
     permanently.
   - It seems impossible to keep up with all the changes a Windows
     Update does.
   - You don't want to disable Windows Updates as they have important
     Security fixes.
 - **Privacy is more than Windows Telemetry**
   
 
Classic approach:
 - **Windows Settings**: That's a good starting point but a lot of things
   cannot be disabled through those settings.
 - **Windows Group Policies**: Windows Group Policies are tedious to work
   with, but it is possible to disable a lot of privacy related things
   with it and there is hope that Windows does what you configured there
   because Windows Group Policies are used by Organizations to control
   their environments.
 - **Registry**: You can set certain values through the Windows Registry.
   This approach should give you even more control than Windows
   Group Policies when you know what to disable. (But you usually don't
   know.) But there should be documentation available through the
   Microsoft Documentation Website what values you can set and what
   effect they should have.
 - **Task Scheduler**
 - **Services**
   

Not so classic approach:
 - **TODO**