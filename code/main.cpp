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
    ab1::VB6String smallImageText,
    ab1::VB6String button1Label,
    ab1::VB6String button1Url,
    ab1::VB6String button2Label,
    ab1::VB6String button2Url) {
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

    DiscordRichPresenceButton buttons[2];
    int buttonCount = 0;

    if (!is_empty(button1Label) && !is_empty(button1Url)) {
        buttons[buttonCount].label = button1Label;
        buttons[buttonCount].url = button1Url;
        ++buttonCount;
    }

    if (!is_empty(button2Label) && !is_empty(button2Url)) {
        buttons[buttonCount].label = button2Label;
        buttons[buttonCount].url = button2Url;
        ++buttonCount;
    }

    if (buttonCount > 0) {
        presence.buttons = buttons;
        presence.buttonCount = buttonCount;
    }

    Discord_UpdatePresence(&presence);
}

extern "C" __declspec(dllexport) void __stdcall ab1_discord_presence_clear() {
    Discord_ClearPresence();
}
