#pragma once

#include "types.hpp"

extern "C" __declspec(dllexport) void __stdcall ab1_discord_initialize(ab1::VB6String clientID);
extern "C" __declspec(dllexport) void __stdcall ab1_discord_release();

extern "C" __declspec(dllexport) void __stdcall ab1_discord_presence_set(ab1::VB6String state, ab1::VB6String details);
extern "C" __declspec(dllexport) void __stdcall ab1_discord_presence_set_with_assets(
    ab1::VB6String state,
    ab1::VB6String details,
    ab1::VB6String largeImageKey,
    ab1::VB6String largeImageText,
    ab1::VB6String smallImageKey,
    ab1::VB6String smallImageText);
extern "C" __declspec(dllexport) void __stdcall ab1_discord_presence_clear();
