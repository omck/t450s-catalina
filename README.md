## T450s Catalina hackintosh w/ OpenCore 0.6.0

#### Specs:
- Intel i7-5600U
- Intel HD 5500  
- 1920x1080 touch screen
- Synaptics click-pad
- Track point 🔴

#### To do:
- WiFi
- Audio
- Battery display / patch
- Fn keys

#### Compromises:
- Had to sacrifice gestures for pad's buttons to work as I'd want

### N.b.

This hack was first assembled using the OpenCore getting started guide. Using a bonkers ig-platform-id at least got the install up and running, debugging the frame buffer issues was done by booting into a live USB burned with Linux Mint and then editing the EFI from there (I'd recommend a **persistent partition** for this sort of "rescue USB", otherwise your tools will vanish between each boot).

For the frame buffer patch described in the getting started guide to work, I had to enable CSM in my BIOS (I've read that enabling "Both BIOS and UEFI" will work as well). Otherwise, I would get a garbled screen, as if the frame buffer didn't get enough memory. I had dismissed the guide's memory patch because of that garbled screen effect and instead had decided to go through and try to boot with *every* Broadwell laptop platform id, each resulting in a kernel panic of course. In the end, it's using the recommended platform id, adding the frame buffer patches from the guide and enabling CSM that works.

To sacrifice gestures in favour of working click-pad buttons, you want to use SSDT-Thinkpad_Clickpad found in the acidathera repository. I also read that to place new SSDTs at the top of your ACPI will ensure it updates.

Refer to the following order for the track point and touch screen to work well:

| Kext |   Plugin     | Enabled |
|---------|--------------|---------|
|VoodooGPIO|-| True |
|VoodooI2C |VoodooI2CServices| True |
|VoodooPS2Controller|-| True |
|VoodooPS2Controller| VoodooPS2Trackpad| True |
|VoodooPS2Controller| VoodooPS2Keyboard| True |
|VoodooPS2Controller| VoodooPS2Mouse| True |
|VoodooPS2Controller| VoodooInput| False |
|VoodooI2C| VoodooInput| False |
|VoodooI2C|-| True |
|VoodooI2C| VoodooI2CHID| True |
|VoodooInput|-| True |

Yes, there's three different VoodooInput kexts in the plist, but we only enable the last one.

