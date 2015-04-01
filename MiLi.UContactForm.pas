unit MiLi.UContactForm;

interface

uses Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms,
  Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, MiLi.UContacts,
  Vcl.Samples.Spin, MiLi.UStrings;

type
  TFContactForm = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    edIP: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    edName: TEdit;
    Label3: TLabel;
    edPort: TSpinEdit;
  private
    { Private declarations }
  public
    { Public declarations }
    class function AddContact(const aContactIP: string): boolean;
  end;


implementation

{$R *.dfm}

class function TFContactForm.AddContact(const aContactIP: string): boolean;
var
  FContactForm: TFContactForm;
begin
  Result := false;
  FContactForm := TFContactForm.Create(Application);
  try
    FContactForm.Caption := sAddContact;
    FContactForm.edIP.Text := aContactIP;
    if FContactForm.ShowModal <> mrOk then
      exit;
    with TContact.Create do
    begin
      FriendlyName := FContactForm.edName.Text;
      InternalIP := FContactForm.edIP.Text;
      Port := FContactForm.edPort.Value;
    end;
    Result := true;
  finally
    FContactForm.Free;
  end;
end;

end.
