
/*
 * AppleUsbPower compatibility table for legacy hardware.
 *
 * Be warned that power supply values can be different
 * for different systems. Depending on the configuration
 * the values must be present in injected IOKitPersonalities
 * for com.apple.driver.AppleUSBMergeNub. iPad remains being
 * the most reliable device for testing USB port charging.
 *
 * Try NOT to rename EC0, H_EC, etc. to EC.
 * These devices are incompatible with macOS and may break
 * at any time. AppleACPIEC kext must NOT load.
 * See the disable code below.
 *
 * Reference USB: https://applelife.ru/posts/550233
 * Reference EC: https://applelife.ru/posts/807985
 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "SsdtEC", 0x00001000)
{
    External (_SB_.PCI0.LPC, DeviceObj)

    Scope (\_SB.PCI0.LPC)
    {
        Device (EC)
        {
            Name (_HID, "ACID0001")  // _HID: Hardware ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }
    }
}
