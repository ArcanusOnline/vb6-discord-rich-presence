VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3135
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   4680
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   ScaleHeight     =   3135
   ScaleWidth      =   4680
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   360
      Left            =   1050
      TabIndex        =   0
      Top             =   690
      Width           =   990
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' En tu Form o Módulo principal
Private cDiscord As New DiscordRPC

Private Sub Command1_Click()

    ActualizarMapa "Aygron", "re polenta"

End Sub

Private Sub Form_Load()
    ' 1. Configuración inicial
    cDiscord.ClientID = "1376696613564846193"
    cDiscord.Initialize
    
    ' 2. Establecer valores base
    cDiscord.LargeImageKey = "arcanus_logo"
    cDiscord.LargeImageText = "List@ para tu proxima aventura?"
    cDiscord.Button1Label = "Web"
    cDiscord.Button1Url = "https://tuweb.com"
    
    ' 3. Estado inicial
    cDiscord.State = "En el Menu Principal"
    cDiscord.Update ' <--- Envía todo a Discord
    
End Sub

' Ejemplo: Cuando el jugador entra a un mapa
Public Sub ActualizarMapa(Nick As String, Nivel As String)
    ' Solo cambias lo que necesitas
    cDiscord.State = Nivel
    cDiscord.Details = Nick
    
    ' Y llamas a Update. La clase recuerda los botones y las imágenes automáticamente.
    cDiscord.Update
End Sub

Private Sub Form_Unload(Cancel As Integer)

    ' Es buena práctica forzar el cierre de la conexión al salir
    If Not cDiscord Is Nothing Then
        cDiscord.Shutdown
        Set cDiscord = Nothing
    End If

End Sub
