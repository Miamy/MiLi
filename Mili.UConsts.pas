unit Mili.UConsts;

interface

const
  // commands
  CmdOk = 200;
  CmdClientConnect = 201;
  CmdClientDisconnect = 202;
  CmdImOnline = 203;
  CmdImOffline = 204;
  CmdTextMessage = 205;
  CmdImageReady = 206;

  ZeroIP = '0.0.0.0';

  ContactListFileName = 'Contacts.dat';

  DefaultPort = 32111;
  DefPacketSize = 8192;

  ClientServerPortDiff = 5;

  HistoryItemsDelimiter = Char(182);
  ReturnDelimiter = '<-->';
  //';;;';

  DefVCardExt = '.milivcard';

implementation

end.
