# aulist
A macOS command line utility that lists audio components known to the system.

```
Usage:  aulist manufacturer type subtype

Options:
    --help        Print usage message
    --no_system   Don't show system plugins (Manufacturer = "Apple", e.g., "appl" and "sys")
    --no_ints     Only show codes as strings; no integers (OSTypes)
    --no_views    Don't show AUs of type 'auvw'

Arguments can be "0" which doesn't filter by that criterion (showing components
by any manufacturer, for instance)

Examples:

* aulist Tdrl aufx          <- all effects by Tokyo Dawn Labs (shown below)

Tokyo Dawn Labs: TDR VOS SlickEQ          ( Tdrl aufx Td10 )  ( 1415869036 1635083896 1415852336 )
Tokyo Dawn Labs: TDR Ultrasonic Filter    ( Tdrl aufx Td1b )  ( 1415869036 1635083896 1415852386 )
Tokyo Dawn Labs: TDR Nova                 ( Tdrl aufx Td5a )  ( 1415869036 1635083896 1415853409 )
Tokyo Dawn Labs: TDR Kotelnikov           ( Tdrl aufx Td96 )  ( 1415869036 1635083896 1415854390 )
-------------------------------------------------------------------------------
4 components

* aulist                    <- all plugins (missing trailing args replaced with 0s)
* aulist appl aufx dcmp     <- a single plugin
* aulist 0    aufx 0        <- all effect plugins (last 0 optional)
* aulist appl 0    0        <- all apple plugins (last two 0s optional)
```
