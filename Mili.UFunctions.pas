unit Mili.UFunctions;

interface

function GetToken(aString: WideString; const SepChar: WideString;
  TokenNum: integer): WideString;
function NumToken(aString: string; const SepChar: string): integer;

function GetInternalIP: string;
function GetExternalIP: string;

function GetUniqueString: string;
function GetAppDir: string; inline;
function GetDataDir: string; inline;

function StrToMime(const aString: string): string;
function StrFromMime(const aString: string): string;

function StrToSendStr(const aString: string): string;
function StrFromSendStr(const aString: string): string;

implementation

uses
  IdHTTP, SysUtils, Classes, WinSock, IdCoderMIME, IdGlobal, StrUtils,
  Mili.UConsts;

function GetToken(aString: WideString;
  const SepChar: WideString; TokenNum: integer): WideString;
var
  Token: WideString;
  StrLen: integer;
  TNum: integer;
  TEnd: integer;
begin
  StrLen := Length(aString);
  TNum := 1;
  TEnd := StrLen;
  while ((TNum <= TokenNum) and (TEnd <> 0)) do
  begin
    TEnd := Pos(SepChar, aString);
    if TEnd <> 0 then
    begin
      Token := Copy(aString, 1, TEnd - 1);
      Delete(aString, 1, TEnd);
      Inc(TNum);
    end
    else
      Token := aString;
  end;
  if TNum >= TokenNum then
    Result := Token
  else
    Result := '';
end;

function NumToken(aString: string; const SepChar: string): integer;
var
  RChar: Char;
  StrLen: integer;
  TNum: integer;
  TEnd: integer;
begin
  if SepChar = '#' then
    RChar := '*'
  else
    RChar := '#';

  StrLen := Length(aString);
  TNum := 0;
  TEnd := StrLen;
  while TEnd <> 0 do
  begin
    Inc(TNum);
    TEnd := Pos(SepChar, aString);
    if TEnd <> 0 then
      aString[TEnd] := RChar;
  end;
  Result := TNum;
end;

function GetExternalIP: string;
begin
  try
    Result := TIdHTTP.Create.Get('http://miamy.net/address.php');
  except on E: Exception do
    Result := GetInternalIP;
  end;
end;

function GetInternalIP: string;
type
  TaPInAddr = array [0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe : PHostEnt;
  pptr : PaPInAddr;
  Buffer : array [0..63] of AnsiChar;
  i : Integer;
  GInitData : TWSADATA;
begin
  WSAStartup($101, GInitData);
  Result := '';
  GetHostName(Buffer, SizeOf(Buffer));
  phe := GetHostByName(Buffer);
  if phe = nil then
    exit;
  pptr := PaPInAddr(Phe^.h_addr_list);
  i := 0;
  while pptr^[i] <> nil do begin
    Result := StrPas(inet_ntoa(pptr^[i]^));
//    break;//?
    Inc(i);
  end;
  WSACleanup;
end;

function GetUniqueString: string;
var
  Guid: TGUID;
  Chars: PChar;
begin
  CreateGUID(Guid);
  SetLength(Result, SizeOf(Guid) * 2);
  Chars := @Guid;
  Classes.BinToHex(Chars, PChar(Result), SizeOf(Guid));
end;

function GetAppDir: string;
begin
  Result := ExtractFilePath(ParamStr(0))
end;

function GetDataDir: string;
begin
  Result := GetAppDir + 'Data\';
end;

function StrFromMime(const aString: string): string;
begin
  Result := TIdDecoderMIME.DecodeString(aString, IndyTextEncoding_UTF8);
end;

function StrToMime(const aString: string): string;
begin
  Result := TIdEncoderMIME.EncodeString(aString, IndyTextEncoding_UTF8);
end;

function StrToSendStr(const aString: string): string;
begin
  Result := ReplaceStr(StrToMime(aString), CR, ReturnDelimiter);
end;

function StrFromSendStr(const aString: string): string;
begin
  Result := ReplaceStr(StrFromMime(aString), ReturnDelimiter, CR);
end;


end.
