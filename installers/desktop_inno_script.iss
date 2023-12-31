; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Colonia de Pesca"
#define MyAppVersion "1.0"
#define MyAppPublisher "Xingu App"
#define MyAppURL "https://www.xinguapp.com/"
#define MyAppExeName "colonia.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{3ADBB8D0-A1F4-4AAE-B75D-4BDFB7E38683}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=C:\Users\Ewerton Duarte\Documents\Projects\colonia\installers
OutputBaseFilename=Colonia de Pesca
SetupIconFile=C:\Users\Ewerton Duarte\Documents\Projects\colonia\assets\icons\fish.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Users\Ewerton Duarte\Documents\Projects\colonia\build\windows\x64\runner\Release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Ewerton Duarte\Documents\Projects\colonia\build\windows\x64\runner\Release\bitsdojo_window_windows_plugin.lib"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Ewerton Duarte\Documents\Projects\colonia\build\windows\x64\runner\Release\colonia.exp"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Ewerton Duarte\Documents\Projects\colonia\build\windows\x64\runner\Release\colonia.lib"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Ewerton Duarte\Documents\Projects\colonia\build\windows\x64\runner\Release\desktop_multi_window_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Ewerton Duarte\Documents\Projects\colonia\build\windows\x64\runner\Release\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Ewerton Duarte\Documents\Projects\colonia\build\windows\x64\runner\Release\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

