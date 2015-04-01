unit Mili.USettingsForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ImgList,
  Vcl.Samples.Spin, Vcl.Mask, ocv.highgui_c, Vcl.ExtCtrls;

type
  TFSettingsForm = class(TForm)
    PageControl: TPageControl;
    btnOk: TButton;
    btnCancel: TButton;
    tsCommon: TTabSheet;
    tsAudioVideo: TTabSheet;
    ImageList: TImageList;
    tsConnection: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    cbCameras: TComboBox;
    cbMicrophones: TComboBox;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    edFriendlyName: TEdit;
    cbAutorun: TCheckBox;
    cbAutoConnect: TCheckBox;
    GroupBox4: TGroupBox;
    Label4: TLabel;
    btnCameraSettings: TButton;
    edIP: TMaskEdit;
    Label5: TLabel;
    sePort: TSpinEdit;
    btnDefPort: TButton;
    btnGetIp: TButton;
    GroupBox5: TGroupBox;
    Label6: TLabel;
    cbSpeakers: TComboBox;
    edUniqueName: TEdit;
    Label7: TLabel;
    edGenerateID: TButton;
    tsChat: TTabSheet;
    rgSending: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure btnDefPortClick(Sender: TObject);
    procedure btnGetIpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCameraSettingsClick(Sender: TObject);
    procedure edGenerateIDClick(Sender: TObject);
  private
    { Private declarations }
    procedure LoadToInterface;
    procedure SaveFromInterface;

    procedure SetupMediaComboBox(aCombo: TComboBox; const aMediaName: string;
      aMediaIndex: integer);
  public
    { Public declarations }
    class function ShowForm: boolean;
  end;

implementation

{$R *.dfm}

uses Mili.UConsts, Mili.UFunctions, MiLi.UContacts, Mili.UMultimedia,
  Mili.USettings;

{ TFSettings }

procedure TFSettingsForm.btnCameraSettingsClick(Sender: TObject);
var
  Capture: pCvCapture;
begin
  Capture := cvCreateCameraCapture({CV_CAP_CAM_0} cbCameras.ItemIndex);
  cvSetCaptureProperty(Capture, CV_CAP_PROP_SETTINGS, 0);

//ShowMessage(FloatToStr(cvGetCaptureProperty(Capture, CV_CAP_PROP_FRAME_WIDTH)) + ' * ' +
//FloatToStr(cvGetCaptureProperty(Capture, CV_CAP_PROP_FRAME_WIDTH)));

//  cvGetCaptureProperty(FCapture, CV_CAP_PROP_FRAME_HEIGHT, CameraResolution[FResolution].cHeight);

end;

procedure TFSettingsForm.btnDefPortClick(Sender: TObject);
begin
  sePort.Value := DefaultPort;
end;

procedure TFSettingsForm.btnGetIpClick(Sender: TObject);
begin
  edIP.EditText := GetExternalIP;
end;

procedure TFSettingsForm.btnOkClick(Sender: TObject);
begin
  SaveFromInterface;
  TSettings.Save;
end;

procedure TFSettingsForm.edGenerateIDClick(Sender: TObject);
begin
  edUniqueName.Text := GetUniqueString;
end;

procedure TFSettingsForm.FormCreate(Sender: TObject);
begin
  FillInputDevicesList(dkVideo, cbCameras.Items);
  FillInputDevicesList(dkMicrophone, cbMicrophones.Items);
  FillInputDevicesList(dkSpeakers, cbSpeakers.Items);
end;

procedure TFSettingsForm.FormShow(Sender: TObject);
begin
  PageControl.ActivePageIndex :=0;
end;

procedure TFSettingsForm.LoadToInterface;
begin
  edUniqueName.Text := TSettings.UniqueName;
  edFriendlyName.Text := TSettings.FriendlyName;
  cbAutoConnect.Checked := TSettings.AutoConnect;

  edIP.EditText := TSettings.IP;
  sePort.Value := TSettings.Port;

  SetupMediaComboBox(cbCameras, TSettings.CameraName, TSettings.CameraIndex);
  SetupMediaComboBox(cbMicrophones, TSettings.MicrophoneName, TSettings.MicrophoneIndex);
  SetupMediaComboBox(cbSpeakers, TSettings.SpeakersName, TSettings.SpeakersIndex);

  rgSending.ItemIndex := TSettings.ChatSendingType;
end;

procedure TFSettingsForm.SaveFromInterface;
begin
  TSettings.UniqueName := edUniqueName.Text;
  TSettings.FriendlyName := edFriendlyName.Text;
  TSettings.AutoConnect := cbAutoConnect.Checked;
  TSettings.ChatSendingType := rgSending.ItemIndex;

  TSettings.IP := edIP.EditText;
  TSettings.Port := sePort.Value;
  TSettings.CameraName := cbCameras.Text;
  TSettings.CameraIndex := cbCameras.ItemIndex;
  TSettings.MicrophoneName := cbMicrophones.Text;
  TSettings.MicrophoneIndex := cbMicrophones.ItemIndex;
  TSettings.SpeakersName := cbSpeakers.Text;
  TSettings.SpeakersIndex := cbSpeakers.ItemIndex;
end;

procedure TFSettingsForm.SetupMediaComboBox(aCombo: TComboBox;
  const aMediaName: string; aMediaIndex: integer);
var
  Index: integer;
begin
  Index := -1;
  aCombo.Enabled := aCombo.Items.Count > 0;
  if aCombo.Enabled then
  begin
    if aMediaName <> '' then
      Index := cbCameras.Items.IndexOf(aMediaName);
    if Index = -1 then
      Index := aMediaIndex;
    if Index = -1 then
      Index := 0;
  end;
  aCombo.ItemIndex := Index;
end;

class function TFSettingsForm.ShowForm: boolean;
var
  SettingsForm: TFSettingsForm;
begin
  SettingsForm := TFSettingsForm.Create(Application);
  try
    SettingsForm.LoadToInterface;
    Result := SettingsForm.ShowModal = mrOk;
  finally
    SettingsForm.Free;
  end;
end;

end.
