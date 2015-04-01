unit MiLi.UStrings;

interface

uses
  MiLi.UTypes;

resourcestring
  sConnected = 'Connected';
  sNotConnected = 'Not connected';
  sBindingStr = 'IP: %s    Port: %d';
  sTextMessage  = 'Text message ';
  sClientIpCommand = 'Client IP ';
  sQuitCommand = 'Quit';
  sImageCommand = 'Image ';

  sAddContact = 'Add contact';

const
  ServiceMessages: array[TServiceMessage] of string =
  ('smVideoCall', 'smVideoCallNotAnswered', 'smVideoCallEnded',
   'smFileSending', 'smFileSended', 'smFileCancelledBySender', 'smFileCancelledByReceiver');

implementation

end.
