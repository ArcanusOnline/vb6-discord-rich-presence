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

In addition to the simple `ab1_discord_presence_set` (state + details), you can set images with:

```vb
Private Declare Sub ab1_discord_presence_set_with_assets Lib "vb6-discord-rich-presence.dll" _
    (ByVal state As String, _
     ByVal details As String, _
     ByVal largeImageKey As String, _
     ByVal largeImageText As String, _
     ByVal smallImageKey As String, _
     ByVal smallImageText As String)
```

Sample usage (replace values with your asset keys configured in your Discord application):

```vb
Call ab1_discord_presence_set_with_assets( _
    "Playing", _
    "Testing RPC", _
    "large_key", _
    "Large tooltip", _
    "small_key", _
    "Small tooltip")
```

> Note: The version of Discord RPC bundled here does not support buttons in rich presence. Only images and text are sent.

### Guía paso a paso (VB6, español)

1. **Compila la DLL de 32 bits**
   - Ejecuta en una consola de Windows dentro de la raíz del repo:
     ```bat
     mkdir build
     cd build
     cmake -A Win32 ..
     cd ..
     cmake --build build
     ```
   - Repite la compilación cada vez que cambies el código C++ o las funciones exportadas.

2. **Copia la DLL donde la usará VB6**
   - Coloca `vb6-discord-rich-presence.dll` de `build/Debug` o `build/Release` en la carpeta `tests` (o en `C:\Windows\System32` si ejecutas desde el IDE).

3. **Abre y configura el proyecto de ejemplo**
   - Abre `tests/prjTest.vbp` en VB6.
   - Sustituye `"<replace-with-your-client-id>"` en `tests/modMain.bas` por el Client ID de tu aplicación de Discord.

4. **(Opcional) Prepara imágenes**
   - En el portal de desarrolladores de Discord, sube los assets y anota sus `largeImageKey` y `smallImageKey`.

5. **Ejecuta el ejemplo**
   - Compila y ejecuta desde VB6. Verás el mensaje "Press OK to clear"; tras pulsar OK se limpia la presencia y se liberan los recursos.

6. **Integra en tu proyecto**
   - Declara las funciones en tu módulo exactamente como en `tests/modMain.bas` (incluyendo `ab1_discord_presence_set_with_assets`).
   - Flujo recomendado: `ab1_discord_initialize` → `ab1_discord_presence_set` o `ab1_discord_presence_set_with_assets` → `ab1_discord_presence_clear` → `ab1_discord_release` al cerrar tu app.
