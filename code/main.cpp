#include <discord_rpc.h>

#include "main.hpp"

namespace {
    bool is_empty(ab1::VB6String value) {
        return value == nullptr || value[0] == '\0';
    }
}

extern "C" __declspec(dllexport) void __stdcall ab1_discord_initialize(ab1::VB6String clientID) {
    auto handlers = DiscordEventHandlers {};

    Discord_Initialize(clientID, &handlers, 1, nullptr);
}

extern "C" __declspec(dllexport) void __stdcall ab1_discord_release() {
    Discord_Shutdown();
}

extern "C" __declspec(dllexport) void __stdcall ab1_discord_presence_set(ab1::VB6String state, ab1::VB6String details) {
    auto presence = DiscordRichPresence {};

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

    if (!is_empty(largeImageKey)) {
        presence.largeImageKey = largeImageKey;
    }

    if (!is_empty(largeImageText)) {
        presence.largeImageText = largeImageText;
    }

    if (!is_empty(smallImageKey)) {
        presence.smallImageKey = smallImageKey;
    }

    if (!is_empty(smallImageText)) {
        presence.smallImageText = smallImageText;
    }

    Discord_UpdatePresence(&presence);
}

extern "C" __declspec(dllexport) void __stdcall ab1_discord_presence_clear() {
    Discord_ClearPresence();
}
