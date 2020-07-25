unit Main;

interface

uses
  Windows, Messages, Vcl.ExtCtrls, Vcl.Mask, Vcl.ExtDlgs, IdGlobal, IdHash,
  IdHashMessageDigest,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Imaging.pngimage,
  HTTPApp,
  Winapi.WinInet,
  math;

var
  cod: integer;
  str: string;

type
  TFrmMain = class(TForm)
    BtnGenerate: TButton;
    Image1: TImage;
    MemoData: TMemo;
    Label1: TLabel;
    EditWidth: TMaskEdit;
    Label2: TLabel;
    EditHeight: TMaskEdit;
    ComboBoxErrCorrLevel: TComboBox;
    Label3: TLabel;
    procedure BtnGenerateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses untPrincipal;
{$R *.dfm}

type
  TQrImage_ErrCorrLevel = (L, M, Q, H);

const
  UrlGoogleQrCode =
    'http://chart.apis.google.com/chart?chs=%dx%d&cht=qr&chld=%s&chl=%s';
  QrImgCorrStr: array [TQrImage_ErrCorrLevel] of string = ('L', 'M', 'Q', 'H');

procedure WinInet_HttpGet(const Url: string; Stream: TStream);
const
  BuffSize = 1024 * 1024;
var
  hInter: HINTERNET;
  UrlHandle: HINTERNET;
  BytesRead: DWORD;
  Buffer: Pointer;
begin
  hInter := InternetOpen('', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if Assigned(hInter) then
  begin
    Stream.Seek(0, 0);
    GetMem(Buffer, BuffSize);
    try
      UrlHandle := InternetOpenUrl(hInter, PChar(Url), nil, 0,
        INTERNET_FLAG_RELOAD, 0);
      if Assigned(UrlHandle) then
      begin
        repeat
          InternetReadFile(UrlHandle, Buffer, BuffSize, BytesRead);
          if BytesRead > 0 then
            Stream.WriteBuffer(Buffer^, BytesRead);
        until BytesRead = 0;
        InternetCloseHandle(UrlHandle);
      end;
    finally
      FreeMem(Buffer);
    end;
    InternetCloseHandle(hInter);
  end
end;

procedure GetQrCode(Width, Height: Word;
  Correction_Level: TQrImage_ErrCorrLevel; const Data: string;
  StreamImage: TMemoryStream);
Var
  EncodedURL: string;
begin
  EncodedURL := Format(UrlGoogleQrCode,
    [Width, Height, QrImgCorrStr[Correction_Level], HTTPEncode(Data)]);
  WinInet_HttpGet(EncodedURL, StreamImage);
end;

procedure TFrmMain.BtnGenerateClick(Sender: TObject);
var
  ImageStream: TMemoryStream;
  pngimage: TPngImage;

begin
  Image1.Picture := nil;
  ImageStream := TMemoryStream.Create;
  pngimage := TPngImage.Create;

  try
    try

      GetQrCode(StrToInt(Trim(EditWidth.Text)), StrToInt(Trim(EditHeight.Text)),
        TQrImage_ErrCorrLevel(ComboBoxErrCorrLevel.ItemIndex),
        MemoData.Lines.Text, ImageStream);
      if ImageStream.Size > 0 then
      begin
        ShowMessage('Qr gerado com nome:' +' ' + nome );
        ImageStream.Position := 0;
        pngimage.LoadFromStream(ImageStream);
        Image1.Picture.Assign(pngimage);
        Image1.Picture.SaveToFile(ExtractFilePath(Application.ExeName) + nome + '.bmp');
      end;
    except
      on E: exception do
        ShowMessage(E.Message);
    end;
  finally
    //ImageStream.Free;
    //pngimage.Free;
  end;
  //Image1.Picture.Free;
  frmPrincipal.button2.Enabled := true;
  frmPrincipal.Show;
  FrmMain.Close;

end;

procedure TFrmMain.FormShow(Sender: TObject);
var
  hashMessageDigest5: TIdHashMessageDigest5;

begin

  hashMessageDigest5 := nil;
  cod := randomrange(1, 1000000000);
  try
    hashMessageDigest5 := TIdHashMessageDigest5.Create;
    str := IdGlobal.IndyLowerCase(hashMessageDigest5.HashStringAsHex
      (inttostr(cod)));

  finally
    hashMessageDigest5.Free;
  end;
  MemoData.Lines.Text := str;
  MemoData.ReadOnly := true;
end;

End.
