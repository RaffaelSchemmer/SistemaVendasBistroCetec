program BistroTec;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMainForm in 'uMainForm.pas' {MainForm},
  Androidapi.JNI.Toast in '..\..\Downloads\BarCode\BarCode\Lib\Androidapi.JNI.Toast.pas',
  FMX.Barcode.IOS in '..\..\Downloads\BarCode\BarCode\Lib\FMX.Barcode.IOS.pas',
  FMX.Barcode.DROID in '..\..\Downloads\BarCode\BarCode\Lib\FMX.Barcode.DROID.pas',
  UntPrincipal in 'UntPrincipal.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  AApplication.CreateForm(TMainForm, MainForm);
  AApplication.CreateForm(TForm1, Form1);
  lication.Run;
end.
