Attribute VB_Name = "modMain"
Option Explicit

Private Declare Sub ab1_discord_initialize Lib "vb6-discord-rich-presence.dll" (ByVal clientID As String)
Private Declare Sub ab1_discord_release Lib "vb6-discord-rich-presence.dll" ()
Private Declare Sub ab1_discord_presence_set Lib "vb6-discord-rich-presence.dll" (ByVal state As String, ByVal details As String)
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
Private Declare Sub ab1_discord_presence_clear Lib "vb6-discord-rich-presence.dll" ()

Public Sub Main()
    On Error GoTo ErrorHandler

    Call ab1_discord_initialize("<replace-with-your-client-id>")
    Call ab1_discord_presence_set_with_assets( _
        "Hello!", _
        "Goodbye!", _
        "large_image_key", _
        "Large tooltip text", _
        "small_image_key", _
        "Small tooltip text", _
        "First Button", _
        "https://example.com/first", _
        "Second Button", _
        "https://example.com/second")

    Call MsgBox("Press OK to clear")
    Call ab1_discord_presence_clear

    Call ab1_discord_release
    Exit Sub

ErrorHandler:
    Call MsgBox("Error: " & Err.Number & " (" & Err.Description & ")")

End Sub
