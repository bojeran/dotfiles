# An Opinion

This document is an attempt to write down an opinion about 3d-printing in general in 2025.

For simplification, the following types of users are differentiated:
- **average consumer**:
    - CAD: none
    - 3d-printer: Don't see a need in one
    - other: Rarely buys items that are fully or partly 3d-printed
- **DIY enthusiast**:
    - CAD: `Fusion`, `Onshape`, `FreeCAD`; Rare: `OpenSCAD`; Super Rare: `SolveSpace`
    - 3d-printer: Mostly printer cost <= 1k; Rare: Printer cost <= 5k;
    - other: get emotionally attached to projects / prints
- **industry pro**:
    - CAD: `Solid Edge`, `Fusion`
    - 3d-printer: >= 10k; Often: print-farms with low-cost printers
    - other: sometimes have a paid job related to CAD, engineering, etc.

Bringing 3d-printing to **average consumers** is fairly difficult as the current most popular 3d-printing technology (FDM printing) takes a lot of space, is fairly unreliable and requires at least some knowledge about:
- **Download Model**: Where to get the 3d-printing files from
- **Slicing**: How to slice the model for a successful print on a computer with specialised software
- **Error handling**: Know what to do when the print fails.

When we compare 3d-printing to 2d-printing we quickly realized that most people learn early how to write documents and operate 2d-printers. But even 2d-printers are fairly complex. For example a lot of people don't know they can print directly on a letter, know about the different paper thicknesses that the printer supports or struggle to customize the print-job before starting the print.

Most print-jobs in 2d-printing are likely the default: A4 paper, black-and-white, one-sided. The equivalent in 3d-printing would be an FDM-printer that has one print head and prints a small object, with single-color PLA material without any support.

Similar to 2d-printing the color / material can run out and both kind of printers can resume printing after restocking.

The use-cases of a 2d-printer are obvious and most of us can not live without printing something with a 2d-printer occasionally. A 3d-printer can solve many issues, but you might sacrifice:
- Safety:
    - Is it harmful?
    - Is it food safe?
    - Is it water tight?
    - Is it flammable?
    - Does it follow industry standards?
- Longevity:
    - Wear and Tear (When does it break?) (No guarantees)
- Money
    - Is it cheaper overall vs. a paid product? (Total Cost of Ownership)
- Quality assurance
    - Is the part broken?

Example scenario that actually happened: There is a popular shower head holder that is printed a lot and has good ratings. However, my specific shower head is quite heavy and at first, the shower head holder had no issues but suddenly while showering the shower head holder failed and the shower head fell on my head. It turns out the shower head holder has a design flaw that it can unscrew itself and can fail.

The above might be one of the reason why 3d-printing did not reach **average consumers** yet and stays within the realms of **DIY enthusiasts** and **industry pros**. The following might change this:
- A platform with 3d-prints approved by **Industry pros** to be safe and tightly integrated with the 3d-printer (huge display (no extra PC needed)), pre-sliced.
- A platform run by the community where 3d-printing files must run through a process with voluntary people that approve the product.
- More realistic is a platform that leverages AI before processed by a community before the files show up in the catalog of the 3d-printer. Allowing everyone to be a tester of the 3d-print files but only after an AI thinks the print will work and the outcome is safe to use.

Other than a 2d-printer you usually have to physically go to the 3d-printer before you can start a print job as you have to make sure you have:
- The right print bed. (Different plastics stick better or worse with certain print beds)
- The print bed is clean.
- The nozzle is clean.
- The correct material must be loaded
- Often the material must be heated for an extended period of time to get rid of moisture that affect the print quality
- ...

Also, other than the 2d-printer the print jobs take much longer to finish.

When people buy a 3d-printer they often start to solve some of the above issues, but I saw no setup yet that solved all of the above issues in an automated fashion and made it super easy to print.
