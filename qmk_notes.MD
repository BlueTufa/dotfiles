# QMK debugging notes

* QMK keycodes ARE scancodes.
* scancodes are defined in the USB HID spec.
* `sudo hid_listen` to listen for keyboard events.
* Layer-toggle + D to activate debug listening.

Debug output:
```C
#include <print.h>
dprintf("%s string", var);
```

Main keymaps:
* [Base keymap for all](https://github.com/BlueTufa/qmk_firmware/blob/master/users/badger/keycodes.h)
* [1up keyboard](https://github.com/BlueTufa/qmk_firmware/tree/master/keyboards/1upkeyboards/1up60rgb/keymaps/badger)
* [Clueboard /66](https://github.com/BlueTufa/qmk_firmware/tree/master/keyboards/clueboard/66/keymaps/badger)
* [Preonic](https://github.com/BlueTufa/qmk_firmware/tree/master/keyboards/preonic/keymaps/badger)
