Attribute VB_Name = "modMain"
Option Explicit

Private Declare Sub ab1_discord_initialize _
                Lib "vb6-discord-rich-presence.dll" (ByVal clientID As String)

Private Declare Sub ab1_discord_release Lib "vb6-discord-rich-presence.dll" ()

Private Declare Sub ab1_discord_presence_set _
                Lib "vb6-discord-rich-presence.dll" (ByVal state As String, _
                                                     ByVal details As String)

Private Declare Sub ab1_discord_presence_set_with_assets _
                Lib "vb6-discord-rich-presence.dll" (ByVal state As String, _
                                                     ByVal details As String, _
                                                     ByVal largeImageKey As String, _
                                                     ByVal largeImageText As String, _
                                                     ByVal smallImageKey As String, _
                                                     ByVal smallImageText As String)

Private Declare Sub ab1_discord_presence_set_with_assets_and_buttons _
                Lib "vb6-discord-rich-presence.dll" (ByVal state As String, _
                                                     ByVal details As String, _
                                                     ByVal largeImageKey As String, _
                                                     ByVal largeImageText As String, _
                                                     ByVal smallImageKey As String, _
                                                     ByVal smallImageText As String, _
                                                     ByVal button1Label As String, _
                                                     ByVal button1Url As String, _
                                                     ByVal button2Label As String, _
                                                     ByVal button2Url As String)

Private Declare Sub ab1_discord_presence_clear Lib "vb6-discord-rich-presence.dll" ()

Public Sub Main()

    On Error GoTo ErrorHandler

    Call ab1_discord_initialize("xx") ' REEMPLAZAR CON ID REAL
    Call ab1_discord_presence_set_with_assets_and_buttons("Jugando", "En el menu principal", "large_key", "Texto Grande", "small_key", "Texto Pequeno", "Sitio Web", "https://google.com", "Discord", "https://discord.gg/ejemplo")

    Call MsgBox("Press OK to clear")
    Call ab1_discord_presence_clear

    Call ab1_discord_release

    Exit Sub

ErrorHandler:
    Call MsgBox("Error: " & Err.Number & " (" & Err.Description & ")")

End Sub
