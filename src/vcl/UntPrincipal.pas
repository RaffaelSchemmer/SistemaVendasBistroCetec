unit UntPrincipal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  IOUtils,
  // Units Necessárias
  IniFiles,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdBaseComponent,
  IdMessage,
  IdExplicitTLSClientServerBase,
  IdMessageClient,
  IdSMTPBase,
  IdSMTP,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL,
  IdAttachmentFile,
  IdText, IdCustomTCPServer, IdCustomHTTPServer, IdHTTPServer, main, Vcl.Mask;

var
  nome, email, nomec: string;

type
  TfrmPrincipal = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    edtAssunto: TEdit;
    Label3: TLabel;
    edtPara: TEdit;
    edtAnexo: TEdit;
    Button2: TButton;
    Label4: TLabel;
    Button3: TButton;
    IdHTTP1: TIdHTTP;
    IdHTTPServer1: TIdHTTPServer;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    MaskEdit1: TMaskEdit;
    Label7: TLabel;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    function EnviarEmail(const AAssunto, ADestino, AAnexo: String): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses UntLogin;
{$R *.dfm}

procedure TfrmPrincipal.Button1Click(Sender: TObject);
var
  lURL: String;
  lResponse: TStringStream;
  lista: Tstringlist;
begin

  lResponse := TStringStream.Create('');
  lista := Tstringlist.Create();
  try
    lURL := 'http://35.199.122.71/insereIngresso.php?nmusuario=' + user +
      '&nmsenha=' + password + '&nmcliente=' + Edit2.Text + '&nmemail=' + edtPara.Text
      + '&nmcelular=' + MaskEdit1.Text + '&nmcodigo=' + inttostr(cod) + '&nmsha=' + str;
    IdHTTP1.Get(lURL, lResponse);
    lResponse.Position := 0;
    lista.LoadFromStream(lResponse);
  finally
    lResponse.Free();
  end;

  if lista[0] = '1' then
  begin

    if EnviarEmail('[ Aquarela Bistrô ] Comprovante de Compra', edtPara.Text,
      edtAnexo.Text) then
    begin
      ShowMessage('E-Mail Enviado com Sucesso!');
      edtPara.Text := '';
      edtAnexo.Text := '';
      Edit1.Text := '';
      MaskEdit1.Text := '';
      Button2.Enabled := false;
    end
    else
      ShowMessage('Não foi possível enviar o e-mail!');
  end
  else
  begin
    ShowMessage
      ('Usuário ou senha inválidos ou não foi possivel registrar o ingresso!');
  end;
  nomec := Edit2.Text;;
  Edit2.Text := '';
end;

procedure TfrmPrincipal.Button2Click(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    if Execute then
      edtAnexo.Text := FileName;
end;

function TfrmPrincipal.EnviarEmail(const AAssunto, ADestino, AAnexo: String): Boolean;
var
  IniFile: TIniFile;
  sFrom: String;
  sBccList: String;
  sHost: String;
  iPort: Integer;
  sUserName: String;
  sPassword: String;
  LStrings: Tstringlist;

  idMsg: TIdMessage;
  IdText: TIdText;
  IdSMTP: TIdSMTP;
  idSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
begin
  try
    try
      // Criação e leitura do arquivo INI com as configurações
      IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Config.ini');
      sFrom := IniFile.ReadString('Email', 'From', sFrom);
      sBccList := IniFile.ReadString('Email', 'BccList', sBccList);
      sHost := IniFile.ReadString('Email', 'Host', sHost);
      iPort := IniFile.ReadInteger('Email', 'Port', iPort);
      sUserName := IniFile.ReadString('Email', 'UserName', sUserName);
      sPassword := IniFile.ReadString('Email', 'Password', sPassword);

      // Configura os parâmetros necessários para SSL
      idSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      idSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      idSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;

      // Variável referente a mensagem
      idMsg := TIdMessage.Create(Self);
      idMsg.CharSet := 'utf-8';
      idMsg.Encoding := meMIME;
      idMsg.From.Name := 'Bistrô';
      idMsg.From.Address := sFrom;
      idMsg.Priority := mpNormal;
      idMsg.Subject := AAssunto;

      // Add Destinatário(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;
      idMsg.CCList.EMailAddresses := 'BistroCetec@gmail.com';
      idMsg.BccList.EMailAddresses := sBccList;
      idMsg.BccList.EMailAddresses := 'BistroCetec@gmail.com'; // Cópia Oculta

      // Variável do texto
      IdText := TIdText.Create(idMsg.MessageParts);

      LStrings := Tstringlist.Create;
      try
        LStrings.Loadfromfile('mensagem.txt');
      finally

      end;

      LStrings.Text := StringReplace(LStrings.Text, nomec, Edit2.Text, []);

      IdText.Body.Add(LStrings.Text);
      IdText.ContentType := 'text/html; text/plain; charset=iso-8859-1';
      IdText := TIdText.Create(idMsg.MessageParts);
      IdText.Body.Add('<html>');
      IdText.Body.Add('<body>');

      IdText.Body.Add('</body>');
      IdText.Body.Add('</html>');
      IdText.ContentType := 'text/html; charset=iso-8859-1';
      // Prepara o Servidor
      IdSMTP := TIdSMTP.Create(Self);
      IdSMTP.IOHandler := idSSLIOHandlerSocket;
      IdSMTP.UseTLS := utUseImplicitTLS;
      IdSMTP.AuthType := satDefault;
      IdSMTP.Host := sHost;
      IdSMTP.AuthType := satDefault;
      IdSMTP.Port := iPort;
      IdSMTP.Username := sUserName;
      IdSMTP.password := sPassword;
      // Conecta e Autentica
      IdSMTP.Connect;
      IdSMTP.Authenticate;
     
      if AAnexo <> EmptyStr then
        if FileExists(AAnexo) then
          TIdAttachmentFile.Create(idMsg.MessageParts, AAnexo);

      // Se a conexão foi bem sucedida, envia a mensagem
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except
          on E: Exception do
          begin
            ShowMessage('Erro ao tentar enviar: ' + E.Message);
          end;
        end;
      end;

      // Depois de tudo pronto, desconecta do servidor SMTP
      if IdSMTP.Connected then
        IdSMTP.Disconnect;

      Result := True;
    finally
      IniFile.Free;

      UnLoadOpenSSLLibrary;

      FreeAndNil(idMsg);
      FreeAndNil(idSSLIOHandlerSocket);
      FreeAndNil(IdSMTP);
    end;
  except
    on E: Exception do
    begin
      Result := False;
    end;
  end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  form1.show;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  form1.Hide;
  nomec := '{NOME}';
  // ShowMessage('Os campos assunto e mensagem são preenchidos automaticamente!!!');
end;

procedure TfrmPrincipal.Button3Click(Sender: TObject);
begin
  nome := Edit1.Text;
  email := edtPara.Text;
  if (Edit1.Text <> '') and (edtPara.Text <> '') and (MaskEdit1.Text <> '') and
    (Edit2.Text <> '') then
  begin
    FrmMain.show;
  end
  else
  begin
    ShowMessage('Informe os campos Nome, número e email! ');
  end;

end;

end.
