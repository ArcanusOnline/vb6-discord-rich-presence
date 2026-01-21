VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "DiscordRPC"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

' --- Declaraciones de la DLL ---
Private Declare Sub ab1_discord_initialize _
                Lib "vb6-discord-rich-presence.dll" (ByVal ClientID As String)

Private Declare Sub ab1_discord_run_callbacks Lib "vb6-discord-rich-presence.dll" ()

Private Declare Sub ab1_discord_release Lib "vb6-discord-rich-presence.dll" ()

Private Declare Sub ab1_discord_presence_set_with_assets_and_buttons _
                Lib "vb6-discord-rich-presence.dll" (ByVal State As String, _
                                                     ByVal Details As String, _
                                                     ByVal LargeImageKey As String, _
                                                     ByVal LargeImageText As String, _
                                                     ByVal SmallImageKey As String, _
                                                     ByVal SmallImageText As String, _
                                                     ByVal Button1Label As String, _
                                                     ByVal Button1Url As String, _
                                                     ByVal Button2Label As String, _
                                                     ByVal Button2Url As String)

Private Declare Sub ab1_discord_presence_clear Lib "vb6-discord-rich-presence.dll" ()

' --- Variables Miembro para guardar el estado ---
Private m_ClientID       As String

Private m_State          As String

Private m_Details        As String

Private m_LargeImageKey  As String

Private m_LargeImageText As String

Private m_SmallImageKey  As String

Private m_SmallImageText As String

Private m_Button1Label   As String

Private m_Button1Url     As String

Private m_Button2Label   As String

Private m_Button2Url     As String

Private m_Initialized    As Boolean

' --- Propiedades ---

Public Property Let ClientID(ByVal value As String)
    m_ClientID = value
End Property

Public Property Let State(ByVal value As String)
    m_State = value
End Property

Public Property Get State() As String
    State = m_State
End Property

Public Property Let Details(ByVal value As String)
    m_Details = value
End Property

Public Property Get Details() As String
    Details = m_Details
End Property

Public Property Let LargeImageKey(ByVal value As String)
    m_LargeImageKey = value
End Property

Public Property Let LargeImageText(ByVal value As String)
    m_LargeImageText = value
End Property

Public Property Let SmallImageKey(ByVal value As String)
    m_SmallImageKey = value
End Property

Public Property Let SmallImageText(ByVal value As String)
    m_SmallImageText = value
End Property

Public Property Let Button1Label(ByVal value As String)
    m_Button1Label = value
End Property

Public Property Let Button1Url(ByVal value As String)
    m_Button1Url = value
End Property

Public Property Let Button2Label(ByVal value As String)
    m_Button2Label = value
End Property

Public Property Let Button2Url(ByVal value As String)
    m_Button2Url = value
End Property

' --- Métodos ---

' Inicializa la conexión con Discord
Public Sub Initialize()

    If m_ClientID = "" Then Exit Sub
    Call ab1_discord_initialize(m_ClientID)
    m_Initialized = True
End Sub

' Envía los datos actuales a Discord
' LLamar a esto después de modificar cualquier propiedad
Public Sub Update()

    If Not m_Initialized Then Exit Sub
    
    Call ab1_discord_presence_set_with_assets_and_buttons(m_State, m_Details, m_LargeImageKey, m_LargeImageText, m_SmallImageKey, m_SmallImageText, m_Button1Label, m_Button1Url, m_Button2Label, m_Button2Url)
End Sub

' Debe llamarse periódicamente (ej. en un Timer)
Public Sub RunCallbacks()

    If m_Initialized Then Call ab1_discord_run_callbacks
End Sub

' Limpia la presencia
Public Sub ClearPresence()

    If m_Initialized Then Call ab1_discord_presence_clear
End Sub

' Cierra la conexión
Public Sub Shutdown()

    If m_Initialized Then
        Call ab1_discord_release
        m_Initialized = False
    End If

End Sub

Private Sub Class_Terminate()
    Call Shutdown
End Sub
