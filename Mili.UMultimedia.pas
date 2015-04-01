unit Mili.UMultimedia;

interface

uses
  Classes;

type
  TDeviceKind = (dkMicrophone, dkSpeakers, dkVideo);

  TDeviceDescriptor = class
  public
    Description, FriendlyName, DevicePath, CLSID: string;
  end;

procedure FillInputDevicesList(aKind: TDeviceKind; aList: TStrings);

implementation

uses
  SysUtils, Windows, ActiveX, DirectShow9, ComObj;

procedure EnumerateVideoInputDevices(aKind: TGUID; aList: TStrings);
const
  IID_IPropertyBag: TGUID = '{55272A00-42CB-11CE-8135-00AA004BB851}';
var
  LDevEnum: ICreateDevEnum;
  ppEnumMoniker: IEnumMoniker;
  pceltFetched: ULONG;
  Moniker: IMoniker;
  PropBag: IPropertyBag;
  pvar: OleVariant;
  hr: HRESULT;
  DeviceDescriptor: TDeviceDescriptor;

  function ReadProperty(const aPropertyName: string): string;
  begin
    Result := '';
    if PropBag.Read(PChar(aPropertyName), pvar, nil) = S_OK then
      Result := string(pvar);
  end;

begin
  CocreateInstance(CLSID_SystemDeviceEnum, nil, CLSCTX_INPROC, IID_ICreateDevEnum, LDevEnum);
  hr := LDevEnum.CreateClassEnumerator(aKind, ppEnumMoniker, 0);
  if hr = S_OK then
  begin
    while(ppEnumMoniker.Next(1, Moniker, @pceltFetched) = S_OK) do
      begin
        Moniker.BindToStorage(nil, nil, IID_IPropertyBag, PropBag);
        DeviceDescriptor := TDeviceDescriptor.Create;

        DeviceDescriptor.Description := ReadProperty('Description');
        DeviceDescriptor.FriendlyName := ReadProperty('FriendlyName');
        DeviceDescriptor.DevicePath := ReadProperty('DevicePath');
        DeviceDescriptor.CLSID := ReadProperty('CLSID');

        aList.AddObject(DeviceDescriptor.FriendlyName, DeviceDescriptor);
        PropBag := nil;
        Moniker := nil;
      end;
  end;
  ppEnumMoniker := nil;
  LDevEnum := nil;
end;


procedure FillInputDevicesList(aKind: TDeviceKind; aList: TStrings);
var
  DeviceType: TGUID;
begin
  aList.Clear;
  case aKind of
    dkMicrophone:
      DeviceType := CLSID_AudioInputDeviceCategory;
    dkVideo:
      DeviceType := CLSID_VideoInputDeviceCategory;
    dkSpeakers:
      DeviceType := CLSID_AudioRendererCategory;
  end;
  try
    CoInitialize(nil);
    try
      EnumerateVideoInputDevices(DeviceType, aList);
    finally
      CoUninitialize;
    end;
  except
    on E:Exception do
        raise;
  end;
end;


end.
