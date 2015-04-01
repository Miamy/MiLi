program MiLi;

uses
  Vcl.Forms,
  MiLi.UMain in 'MiLi.UMain.pas' {FMain},
  MiLi.UContacts in 'MiLi.UContacts.pas',
  MiLi.UStrings in 'MiLi.UStrings.pas',
  MiLi.UContactForm in 'MiLi.UContactForm.pas' {FContactForm},
  MiLi.UClientsDM in 'MiLi.UClientsDM.pas' {ClientsDM: TDataModule},
  MiLi.UServersDM in 'MiLi.UServersDM.pas' {ServersDM: TDataModule},
  Mili.UFunctions in 'Mili.UFunctions.pas',
  Mili.UConsts in 'Mili.UConsts.pas',
  MiLi.UTypes in 'MiLi.UTypes.pas',
  Mili.USettingsForm in 'Mili.USettingsForm.pas' {FSettingsForm},
  Mili.UMultimedia in 'Mili.UMultimedia.pas',
  Mili.USettings in 'Mili.USettings.pas',
  Mili.UHistory in 'Mili.UHistory.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TClientsDM, ClientsDM);
  Application.CreateForm(TServersDM, ServersDM);
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
