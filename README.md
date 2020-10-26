## T450s Catalina hackintosh w/ OpenCore 0.6.0

#### Specs / Functional:
- Intel i7-5600U
- Intel HD 5500  
- 1920 x 1080
- Synaptics click-pad
- Track point 🔴
- WiFi
- Audio (Speakers & Jack)
- CPU Friend
- Fn keys (Not perfect, but does the job)

#### To do:
- Battery display / patch
- Touchsreen

#### Power Management Settings
##### This prevents a CMOS corruption error when sleeping
- hibernatemode 0
- proximitywake 0
- (Not tested) standby 0
- (Not tested) autopoweroff 0



### N.b.

This hack was first assembled using the OpenCore getting started guide. Using a bonkers ig-platform-id at least got the install up and running, debugging the frame buffer issues was done by booting into a live USB burned with Linux Mint and then editing the EFI from there (I'd recommend a persistent partition for this sort of "rescue USB", otherwise your tools will vanish between each boot).

For the frame buffer patch described in the getting started guide to work, **I had to enable CSM in my BIOS** (I've read that enabling "Both BIOS and UEFI" will work as well). Otherwise, I would get a garbled screen, as if the frame buffer didn't get enough memory. I had dismissed the guide's memory patch because of that garbled screen effect and instead had decided to go through and try to boot with *every* Broadwell laptop platform id, each resulting in a kernel panic of course. In the end, it's using the recommended platform id, adding the frame buffer patches from the guide and enabling CSM that works.

