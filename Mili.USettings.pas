unit Mili.USettings;

interface

uses
  Classes, Forms, IniFiles, System.SysUtils;

type
  TSettings = class
  strict private
    class var
      FIniFile: TIniFile;

      FPort: Word;
      FIP: string;
      FAutoConnect: boolean;
      FFriendlyName: string;
      FUniqueName: string;
      FLastContact: string;

      FCameraName: string;
      FCameraIndex: integer;
      FMicrophoneIndex: integer;
      FMicrophoneName: string;
      FSpeakersIndex: integer;
      FSpeakersName: string;
      FChatSendingType: integer;

    class function GetIniFileName: string;
    class function GetIniFile: TIniFile; static;

    class property IniFile: TIniFile read GetIniFile write FIniFile;
  public
    class procedure Load;
    class procedure Save;

    class procedure Init;
    class procedure Done;

    class procedure WriteFormDimensions(aForm: TCustomForm);
    class procedure ReadFormDimensions(aForm: TCustomForm; aDefWidth, aDefHeight: integer);
    class procedure WriteProperty(aOwner: TCustomForm; const aPropertyName: string; aValue: integer);
    class function ReadProperty(aOwner: TCustomForm; const aPropertyName: string; aDefValue: integer): integer;

    class property IP: string read FIP write FIP;
    class property Port: Word read FPort write FPort;
    class property FriendlyName: string read FFriendlyName write FFriendlyName;
    class property UniqueName: string read FUniqueName write FUniqueName;

    class property AutoConnect: boolean read FAutoConnect write FAutoConnect;
    class property LastContact: string read FLastContact write FLastContact;
    class property ChatSendingType: integer read FChatSendingType write FChatSendingType;

    class property CameraName: string read FCameraName write FCameraName;
    class property CameraIndex: integer read FCameraIndex write FCameraIndex;
    class property MicrophoneName: string read FMicrophoneName write FMicrophoneName;
    class property MicrophoneIndex: integer read FMicrophoneIndex write FMicrophoneIndex;
    class property SpeakersName: string read FSpeakersName write FSpeakersName;
    class property SpeakersIndex: integer read FSpeakersIndex write FSpeakersIndex;
  end;

implementation


{ TSettings }

uses Mili.UFunctions, Mili.UConsts;

class procedure TSettings.Done;
begin
  Save;
  if Assigned(FIniFile) then
    FreeAndNil(FIniFile);
end;

class function TSettings.GetIniFile: TIniFile;
begin
  if not Assigned(FIniFile) then
    FIniFile := TIniFile.Create(GetIniFileName);
  Result := FIniFile;
end;

class function TSettings.GetIniFileName: string;
begin
  Result := GetDataDir + 'MiLi.ini';
end;


class procedure TSettings.Init;
begin
  Load;
end;

class procedure TSettings.Load;
begin
  FPort := IniFile.ReadInteger('Connection', 'Port', DefaultPort);
  FIP := IniFile.ReadString('Connection', 'IP', ZeroIP);

  FAutoConnect := IniFile.ReadBool('Common', 'AutoConnect', false);
  FFriendlyName := IniFile.ReadString('Common', 'FriendlyName', 'My name');
  FUniqueName := IniFile.ReadString('Common', 'UniqueName', GetUniqueString);
  FLastContact := IniFile.ReadString('Common', 'LastContact', '');
  FChatSendingType := IniFile.ReadInteger('Chat', 'ChatSendingType', 0);

  FCameraName := IniFile.ReadString('Multimedia', 'CameraName', '');
  FCameraIndex := IniFile.ReadInteger('Multimedia', 'CameraIndex', -1);

  FMicrophoneName := IniFile.ReadString('Multimedia', 'MicrophoneName', '');
  FMicrophoneIndex := IniFile.ReadInteger('Multimedia', 'MicrophoneIndex', -1);

  FSpeakersName := IniFile.ReadString('Multimedia', 'SpeakersName', '');
  FSpeakersIndex := IniFile.ReadInteger('Multimedia', 'SpeakersIndex', -1);
end;

class procedure TSettings.ReadFormDimensions(aForm: TCustomForm; aDefWidth, aDefHeight: integer);
begin
  with aForm do
  begin
    if aDefWidth > -1 then
      Width := IniFile.ReadInteger(aForm.Name, 'Width', aDefWidth);
    if aDefHeight > -1 then
      Height := IniFile.ReadInteger(aForm.Name, 'Height', aDefHeight);
    Left := IniFile.ReadInteger(aForm.Name, 'Left', (Screen.Width - Width) div 2);
    Top  := IniFile.ReadInteger(aForm.Name, 'Top', (Screen.Height - Height) div 2);
  end;
end;

class function TSettings.ReadProperty(aOwner: TCustomForm;
  const aPropertyName: string; aDefValue: integer): integer;
begin
  Result := IniFile.ReadInteger(aOwner.Name, aPropertyName, aDefValue);
end;

class procedure TSettings.Save;
begin
  IniFile.WriteInteger('Connection', 'Port', FPort);
  IniFile.WriteString('Connection', 'IP', FIP);

  IniFile.WriteBool('Common', 'AutoConnect', FAutoConnect);
  IniFile.WriteString('Common', 'FriendlyName', FFriendlyName);
  IniFile.WriteString('Common', 'UniqueName', FUniqueName);
  IniFile.WriteString('Common', 'LastContact', FLastContact);

  IniFile.WriteInteger('Chat', 'ChatSendingType', FChatSendingType);

  IniFile.WriteString('Multimedia', 'CameraName', FCameraName);
  IniFile.WriteInteger('Multimedia', 'CameraIndex', FCameraIndex);
  IniFile.WriteString('Multimedia', 'MicrophoneName', FMicrophoneName);
  IniFile.WriteInteger('Multimedia', 'MicrophoneIndex', FMicrophoneIndex);
  IniFile.WriteString('Multimedia', 'SpeakersName', FSpeakersName);
  IniFile.WriteInteger('Multimedia', 'SpeakersIndex', FSpeakersIndex);

end;

class procedure TSettings.WriteFormDimensions(aForm: TCustomForm);
begin
  with aForm do
  begin
    IniFile.WriteInteger(aForm.Name, 'Left', Left);
    IniFile.WriteInteger(aForm.Name, 'Top', Top);
    IniFile.WriteInteger(aForm.Name, 'Width', Width);
    IniFile.WriteInteger(aForm.Name, 'Height', Height);
  end;
end;

class procedure TSettings.WriteProperty(aOwner: TCustomForm;
  const aPropertyName: string; aValue: integer);
begin
  IniFile.WriteInteger(aOwner.Name, aPropertyName, aValue);
end;

end.
