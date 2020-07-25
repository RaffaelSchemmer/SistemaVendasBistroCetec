unit UntLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, System.ImageList, FMX.ImgList, FMX.MultiView,
  FMX.Objects, FMX.Layouts, FMX.Edit, IdTCPServer, IdCmdTCPServer,
  IdHTTPProxyServer, IdCustomTCPServer, IdCustomHTTPServer, IdHTTPServer,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  FMX.ScrollBox, FMX.Memo;

var
  user, password: string;

type
  TForm1 = class(TForm)
    LayoutPrincipal: TLayout;
    ImageList1: TImageList;
    PnlLogin: TPanel;
    Button2: TButton;
    Circle1: TCircle;
    Layout1: TLayout;
    Edit1: TEdit;
    IdHTTP1: TIdHTTP;
    IdHTTPServer1: TIdHTTPServer;
    Edit2: TEdit;
    Brush1: TBrushObject;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses untprincipal;

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}

procedure TForm1.Button2Click(Sender: TObject);
var
  lURL: String;
  lResponse: TStringStream;
  lista: Tstringlist;
begin

  lResponse := TStringStream.Create('');
  lista := Tstringlist.Create();
  try
    lURL := 'http://35.199.122.71/login.php?nmusuario=' + Edit1.text +
      '&nmsenha=' + Edit2.text + '&tipousuario=1';
    IdHTTP1.Get(lURL, lResponse);
    lResponse.Position := 0;
    lista.LoadFromStream(lResponse);
  finally
    lResponse.Free();
  end;

  if lista[0] = '1' then
  begin

    ShowMessage('Seja bem vinda ' + Edit1.Text + ' novamente!');

    user := Edit1.text;
    password := Edit2.text;
    // PnlLogin.Visible := false;
    // PnlPrincipal.Visible := true;
    frmPrincipal.Show;
    Form1.Hide;
    ShowMessage('Os campos "assunto" e "mensagem" são preenchidos automaticamente, os outros devem ser preenchidos para geração do Qr!!!');
    ShowMessage('Após a geração é necessário anexar o Qr ao email e depois basta enviar.');

  end
  else
  begin
    ShowMessage('Usuário ou senha inválidos!');
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Perguntar ao banco por perfil

end;

procedure TForm1.Image2Click(Sender: TObject);
begin
  // ShellExecute(Handle,'open','http://www.ucs.br/cetec',nil,nil,nil);
end;

end.
