# aulist
A macOS command line utility that lists audio components known to the system.

```
Usage:  aulist manufacturer type subtype

Arguments can be "0" which doesn't filter by that criterion (showing components
by any manufacturer, for instance)

Examples:

* aulist appl aufx dcmp    <- a single plugin
* aulist 0    aufx 0       <- all effect plugins
* aulist appl 0    0       <- all apple plugins
```
