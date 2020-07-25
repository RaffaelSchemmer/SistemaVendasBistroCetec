unit uMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.Messaging,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, System.Actions, FMX.ActnList,
  FMX.Edit, FMX.Media, ZXing.BarcodeFormat, IPPeerClient, IPPeerServer,
  Data.Cloud.CloudAPI, Data.Cloud.AzureAPI, IdCustomTCPServer,
  IdCustomHTTPServer, IdHTTPServer, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, FMX.StdActns, FMX.MediaLibrary.Actions,
  System.Tether.Manager, System.Tether.AppProfile}, ZXing.ReadResult, ZXing.ScanManager,
  FMX.Platform, FMX.Layouts, IPPeerClient, IPPeerServer, System.Tether.Manager,
  System.Tether.AppProfile,
  FMX.Barcode.DROID,
  FMX.Barcode.IOS, FMX.StdActns, FMX.MediaLibrary.Actions, IdCustomTCPServer,
  IdCustomHTTPServer, IdHTTPServer, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Data.Cloud.CloudAPI, Data.Cloud.AzureAPI;

type
  TMainForm = class(TForm)
    ToolBar1: TToolBar;
    butStart: TButton;
    CameraComponent1: TCameraComponent;
    TetheringManager1: TTetheringManager;
    TetheringAppProfile1: TTetheringAppProfile;
    timAutoConnect: TTimer;
    StyleBook1: TStyleBook;
    ActionList1: TActionList;
    ShowShareSheetAction1: TShowShareSheetAction;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Text1: TText;
    IdHTTP1: TIdHTTP;
    IdHTTPServer1: TIdHTTPServer;
    Timer1: TTimer;
    Brush1: TBrushObject;
    imgCamera: TImage;
    AniIndicator1: TAniIndicator;
    AzureConnectionInfo1: TAzureConnectionInfo;
    Rectangle3: TRectangle;
    procedure FormCreate(Sender: TObject);
    procedure butStartClick(Sender: TObject);
    procedure butStopClick(Sender: TObject);
    procedure CameraComponent1SampleBufferReady(Sender: TObject;
      const ATime: TMediaTime);
    procedure Timer1Timer(Sender: TObject);
    procedure Rectangle3Click(Sender: TObject);

  private

    fInProgress: Boolean;
    fScanManager: TScanManager;
    fScanInProgress: Boolean;
    fFrameTake: Integer;

    procedure GetImage();
    function AppEvent(AAppEvent: TApplicationEvent; AContext: TObject): Boolean;

  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  camerastatus : boolean;
  start : boolean;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}

uses UntPrincipal, System.Threading, FMX.VirtualKeyboard;

function TMainForm.AppEvent(AAppEvent: TApplicationEvent;
  AContext: TObject): Boolean;
begin
  Result := False;
  case AAppEvent of
    TApplicationEvent.WillBecomeInactive, TApplicationEvent.EnteredBackground,
      TApplicationEvent.WillTerminate:
      begin
        CameraComponent1.Active := False;
        Result := True;
      end;
  end;
end;

procedure TMainForm.GetImage;
var
  scanBitmap: TBitmap;
  ReadResult: TReadResult;
  lURL: String;
  lResponse: TStringStream;
  lista: Tstringlist;
  parte: Tstringlist;

begin
  CameraComponent1.SampleBufferToBitmap(imgCamera.Bitmap, True);

  if (fScanInProgress) then
  begin
    exit;
  end;

  { This code will take every 1 frame. }
  inc(fFrameTake);
  if (fFrameTake mod 4 <> 0) then
  begin
    exit;
  end;

  scanBitmap := TBitmap.Create();
  scanBitmap.Assign(imgCamera.Bitmap);
  ReadResult := nil;

  TTask.Run(
    procedure
    begin
      try
        fScanInProgress := True;
        try
          ReadResult := fScanManager.Scan(scanBitmap);
        except
          on E: Exception do
          begin
            exit;
          end;
        end;

        TThread.Synchronize(nil,
          procedure
          begin

            if (ReadResult <> nil) then
            begin

              if (ReadResult.text <> '') then
              begin
                 ShowMessage('xuxu');
                lResponse := TStringStream.Create('');
                parte := Tstringlist.Create();
                lista := Tstringlist.Create();

                try
                  lURL := 'http://127.0.0.1/LoginGame.php? nmsha=' + ReadResult.text;

                  IdHTTP1.Get(lURL, lResponse);
                  lResponse.Position := 0;
                  lista.LoadFromStream(lResponse);
                finally
                  lResponse.Free();
                end;


                parte.Delimiter := ':'; // Separador
                parte.DelimitedText := lista[0]; // Separa Strings
                if parte[0] = '1' then
                begin

                  Timer1.enabled := True;
                  Rectangle1.Visible := false;
                  Rectangle2.Opacity := 1;
                  Rectangle2.Fill.Color := TAlphaColors.Lightgreen;
                  Text1.text := 'Seja bem vindo ao Kahoot! ' + parte[1];

                end
                else if parte[0] = '0' then
                begin

                  Timer1.enabled := True;
                  Rectangle1.Visible := false;
                  Rectangle2.Opacity := 1;
                  Rectangle2.Fill.Color := TAlphaColors.Palevioletred;
                  Text1.text := 'Jogo não encontrado';
                end;

                CameraComponent1.Active := false;
                camerastatus := false;
                imgCamera.bitmap := nil;
                imgCamera.visible := false;
              end;

            end;

          end);

      finally
        ReadResult.Free;
        scanBitmap.Free;
        fScanInProgress := False;
      end;

    end);
end;

procedure TMainForm.Rectangle3Click(Sender: TObject);
var
ReadResult: TReadResult;
scanBitmap: TBitmap;
begin
//ReadResult := nil;

REctangle3.Visible:=false;
//fScanManager.Scan(scanBitmap);

//ReadResult.Free;
//scanBitmap.Free;




end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin

  Rectangle2.Opacity := 0;
  Text1.text := '';
  Rectangle1.Visible := false;
  Timer1.enabled := false;


end;

procedure TMainForm.butStartClick(Sender: TObject);

begin
rectangle3.Visible:=true;
  if start = false then
  begin

    //layout2.visible := false;
    //text2.visible := false;
    start := true;

  end;
  if camerastatus = false then
  begin
    Imgcamera.visible := true;

    imgCamera.visible := true;
    Rectangle1.visible := true;
    fScanManager.Free;

  fScanManager := TScanManager.Create(TBarcodeFormat.Auto, nil);

  CameraComponent1.Quality := FMX.Media.TVideoCaptureQuality.MediumQuality;
  CameraComponent1.Active := False;
  CameraComponent1.Kind := FMX.Media.TCameraKind.BackCamera;
  CameraComponent1.FocusMode := FMX.Media.TFocusMode.ContinuousAutoFocus;
  CameraComponent1.Active := True;
  camerastatus := true;

  end
  else
  begin

    Imgcamera.visible := false;
    Rectangle1.visible := false;
    CameraComponent1.Active := false;
    camerastatus := false;
  end;
end;

// Desliga a camera
procedure TMainForm.butStopClick(Sender: TObject);
begin
  CameraComponent1.Active := False;
end;

// Inicia o programa
procedure TMainForm.FormCreate(Sender: TObject);
var
  AppEventSvc: IFMXApplicationEventService;
begin
Rectangle3.Visible:= false;{
  start := false;
  camerastatus := true;
  Rectangle1.visible := false;
  //layout2.visible := true;

  CameraComponent1.Active := true;
  if TPlatformServices.Current.SupportsPlatformService
    (IFMXApplicationEventService, IInterface(AppEventSvc)) then
  begin
    AppEventSvc.SetApplicationEventHandler(AppEvent);
  end;

  fFrameTake := 0;
  fInProgress := False; }
  camerastatus := true;
  CameraComponent1.Active := true;
  if TPlatformServices.Current.SupportsPlatformService
    (IFMXApplicationEventService, IInterface(AppEventSvc)) then
  begin
    AppEventSvc.SetApplicationEventHandler(AppEvent);
  end;
end;

// Sincroniza a leitura do QR
procedure TMainForm.CameraComponent1SampleBufferReady(Sender: TObject;
const ATime: TMediaTime);
begin
  TThread.Synchronize(TThread.CurrentThread, GetImage);
end;

end.
