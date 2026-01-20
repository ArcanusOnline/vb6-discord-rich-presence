# vb6-discord-rich-presence

Un wrapper robusto escrito en C++ para interactuar con la funcionalidad Rich Presence de Discord desde Visual Basic 6 (VB6) y otros lenguajes antiguos (legacy).

## Características

- **Rich Presence**: Establece estado, detalles y marcas de tiempo (gestionado automáticamente).
- **Assets**: Soporte para imágenes grandes y pequeñas con tooltips (texto flotante).
- **Botones**: **[NUEVO]** Soporte para hasta 2 botones clicables (Visibles para otros usuarios).
- **Sin fugas de memoria**: Maneja de forma segura la asignación y liberación de memoria para evitar crasheos en VB6.

## Compilación

### Requisitos previos
- CMake (3.10+)
- Visual Studio (con soporte para C++)
- Git

### Pasos
1. Abre una terminal en la raíz del repositorio.
2. Genera los archivos de construcción (Es obligatorio forzar 32-bits para VB6):
   ```bash
   mkdir build
   cd build
   cmake -A Win32 ..
   cd ..
   ```
3. Compila la librería:
   ```bash
   cmake --build build --config Release
   ```
   La DLL resultante se ubicará en `build/Release/vb6-discord-rich-presence.dll`.

## Uso en VB6

### 1. Configuración de Archivos
Copia `vb6-discord-rich-presence.dll` a:
- `C:\Windows\System32` (Recomendado para usar desde el IDE de VB6)
- O junto a tu ejecutable `.exe` compilado.

### 2. Declaraciones
Agrega las siguientes declaraciones en un Módulo (`.bas`):

```vb
Public Declare Sub ab1_discord_initialize Lib "vb6-discord-rich-presence.dll" (ByVal clientID As String)
Public Declare Sub ab1_discord_run_callbacks Lib "vb6-discord-rich-presence.dll" ()
Public Declare Sub ab1_discord_release Lib "vb6-discord-rich-presence.dll" ()
Public Declare Sub ab1_discord_presence_clear Lib "vb6-discord-rich-presence.dll" ()

' Presencia Básica
Public Declare Sub ab1_discord_presence_set Lib "vb6-discord-rich-presence.dll" ( _
    ByVal state As String, ByVal details As String)

' Presencia con Imágenes
Public Declare Sub ab1_discord_presence_set_with_assets Lib "vb6-discord-rich-presence.dll" ( _
    ByVal state As String, ByVal details As String, _
    ByVal largeImageKey As String, ByVal largeImageText As String, _
    ByVal smallImageKey As String, ByVal smallImageText As String)

' Presencia con Imágenes Y Botones
Public Declare Sub ab1_discord_presence_set_with_assets_and_buttons Lib "vb6-discord-rich-presence.dll" ( _
    ByVal state As String, ByVal details As String, _
    ByVal largeImageKey As String, ByVal largeImageText As String, _
    ByVal smallImageKey As String, ByVal smallImageText As String, _
    ByVal button1Label As String, ByVal button1Url As String, _
    ByVal button2Label As String, ByVal button2Url As String)
```

### 3. Código de Ejemplo
```vb
Sub Main()
    ' 1. Inicializar
    ab1_discord_initialize "TU_CLIENT_ID_AQUI"
    
    ' 2. Establecer Presencia con Botones
    ab1_discord_presence_set_with_assets_and_buttons _
        "Jugando Solo", "Partida Clasificatoria", _
        "hero_icon", "Héroe Nivel 99", _
        "badge_rank", "Liga Diamante", _
        "Ver Perfil", "https://tu-sitio.com/perfil", _
        "Unirse al Discord", "https://discord.gg/ejemplo"
        
    ' 3. Bucle Principal (Llamar a run_callbacks periódicamente, e.g., en un Timer)
    ' ab1_discord_run_callbacks 
    
    ' 4. Limpieza al salir
    ab1_discord_presence_clear
    ab1_discord_release
End Sub
```

> **Importante**: Los botones **NO son visibles para ti mismo**. Debes pedirle a otro usuario que vea tu perfil o verificar desde una cuenta secundaria para confirmar que funcionan.

## Licencia
Licencia MIT.
