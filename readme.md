# vb6-discord-rich-presence

A small wrapper written in C++ to interact with Discord's Rich Presence functionality from an old language.

### Building

First, generate the required Makefiles:
```
mkdir build
cd build
cmake -A Win32 ..
cd ..
```
Then compile the library:
```
cmake --build build
```

**NOTE:** It's important to use CMake's `-A Win32` flag because VB6 isn't able to use 64 bits DLLs.

### Testing

Move the .dll file generated after building (either at `build/Debug` or `build/Release`) to the `tests` folder.
Then, open the VB6 project, compile the executable, and click run.
If you wish to run it from the IDE you might need to move the .dll to `System32`.

### Presence customization from VB6

In addition to the simple `ab1_discord_presence_set` (state + details), you can now set images and buttons with:

```vb
Private Declare Sub ab1_discord_presence_set_with_assets Lib "vb6-discord-rich-presence.dll" _
    (ByVal state As String, _
     ByVal details As String, _
     ByVal largeImageKey As String, _
     ByVal largeImageText As String, _
     ByVal smallImageKey As String, _
     ByVal smallImageText As String, _
     ByVal button1Label As String, _
     ByVal button1Url As String, _
     ByVal button2Label As String, _
     ByVal button2Url As String)
```

Sample usage (replace values with your asset keys and URLs configured in your Discord application):

```vb
Call ab1_discord_presence_set_with_assets( _
    "Playing", _
    "Testing RPC", _
    "large_key", _
    "Large tooltip", _
    "small_key", _
    "Small tooltip", _
    "Visit site", _
    "https://example.com", _
    "Support", _
    "https://example.com/support")
```

Buttons are only sent when both label and URL are provided; leave them empty if you do not need them.
