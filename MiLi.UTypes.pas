unit MiLi.UTypes;

interface

type
  TMessageKind = (mkText, mkNotify, mkVideo, mkAudio, mkFile);

  TServiceMessage = (smVideoCall, smVideoCallNotAnswered, smVideoCallEnded,
    smFileSending, smFileSended, smFileCancelledBySender, smFileCancelledByReceiver);

  TItemRec = record
    Index: integer;
  end;
  PItemRec = ^TItemRec;

var
  FrameNumber: integer;

implementation

uses
  MiLi.UContacts;


end.
