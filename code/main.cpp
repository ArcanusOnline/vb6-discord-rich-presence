#define _CRT_SECURE_NO_WARNINGS // Evita errores de compilación por funciones "antiguas"
#include <discord_rpc.h>
#include <cstring> // Necesario para copiar texto
#include "main.hpp"

// --- ZONA DE MEMORIA SEGURA ---
// Estas variables se guardan fuera de las funciones para que no se borren
// cuando VB6 termine de llamar a la DLL.
namespace {
    static DiscordEventHandlers g_handlers; // Manejadores de eventos persistentes
    static char g_applicationId[256];       // Espacio seguro para guardar el ID de Discord

    bool is_empty(ab1::VB6String value) {
        return value == nullptr || value[0] == '\0';
    }
}
// ------------------------------

extern "C" __declspec(dllexport) void __stdcall ab1_discord_initialize(ab1::VB6String clientID) {
    // 1. Limpiamos la memoria antigua por seguridad
    memset(&g_handlers, 0, sizeof(g_handlers));
    memset(g_applicationId, 0, sizeof(g_applicationId));

    // 2. Guardamos una COPIA del ID. VB6 borra el original, así que necesitamos nuestra propia copia.
    if (!is_empty(clientID)) {
        strncpy(g_applicationId, clientID, sizeof(g_applicationId) - 1);
    }

    // 3. Iniciamos Discord usando nuestra memoria segura
    Discord_Initialize(g_applicationId, &g_handlers, 1, nullptr);
}

// ESTA FUNCION ES NUEVA Y NECESARIA
extern "C" __declspec(dllexport) void __stdcall ab1_discord_run_callbacks() {
    // Permite que la librería "respire" y procese mensajes
    Discord_RunCallbacks();
}

extern "C" __declspec(dllexport) void __stdcall ab1_discord_release() {
    Discord_Shutdown();
}

extern "C" __declspec(dllexport) void __stdcall ab1_discord_presence_set(ab1::VB6String state, ab1::VB6String details) {
    auto presence = DiscordRichPresence {}; 
    // Inicializar la estructura vacía limpia la basura de la memoria automáticamente

    presence.state = state;
    presence.details = details;

    Discord_UpdatePresence(&presence);
}

extern "C" __declspec(dllexport) void __stdcall ab1_discord_presence_set_with_assets(
    ab1::VB6String state,
    ab1::VB6String details,
    ab1::VB6String largeImageKey,
    ab1::VB6String largeImageText,
    ab1::VB6String smallImageKey,
    ab1::VB6String smallImageText) {
    
    auto presence = DiscordRichPresence {};

    presence.state = state;
    presence.details = details;

    if (!is_empty(largeImageKey)) presence.largeImageKey = largeImageKey;
    if (!is_empty(largeImageText)) presence.largeImageText = largeImageText;
    if (!is_empty(smallImageKey)) presence.smallImageKey = smallImageKey;
    if (!is_empty(smallImageText)) presence.smallImageText = smallImageText;

    Discord_UpdatePresence(&presence);
}

extern "C" __declspec(dllexport) void __stdcall ab1_discord_presence_clear() {
    Discord_ClearPresence();
}