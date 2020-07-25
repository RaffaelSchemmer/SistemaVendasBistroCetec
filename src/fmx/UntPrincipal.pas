unit UntPrincipal;

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

var user,senha:string;
type
  TForm1 = class(TForm)
    LayoutPrincipal: TLayout;
    ImageList1: TImageList;
    Button2: TButton;
    Layout1: TLayout;
    Edit1: TEdit;
    Edit2: TEdit;
    IdHTTP1: TIdHTTP;
    IdHTTPServer1: TIdHTTPServer;
    Image1: TImage;
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

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}
uses uMainForm;

procedure TForm1.Button2Click(Sender: TObject);


begin
{
  lResponse := TStringStream.Create('');
  lista := TStringlist.Create();
  try
    lURL := 'http://35.199.122.71/login.php?nmusuario='+Edit1.text+'&nmsenha='+Edit2.Text+'&tipousuario=2';
    idHttp1.Get(lURL, lResponse);
    lResponse.Position := 0;
    lista.LoadFromStream(lResponse);
  finally
    lResponse.Free();
  end; }

  {if lista[0] = '1' then
  begin
    user := edit1.Text;
    senha := edit2.Text;

  end
  else
  begin
    ShowMessage('Usuário ou senha inválidos!');
  end;  }
  form1.Hide;
    MainForm.Show;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  // Perguntar ao banco por perfil
  //form1.Fill := MainForm.Brush1.Brush;

end;

procedure TForm1.Image2Click(Sender: TObject);
begin
  // ShellExecute(Handle,'open','http://www.ucs.br/cetec',nil,nil,nil);
end;

end.
