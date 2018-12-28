unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Platform, System.Messaging, FMX.MediaLibrary,
  FMX.Objects;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Image1: TImage;
    procedure SpeedButton1Click(Sender: TObject);
   // procedure Button1Click(Sender: TObject);
  private
       { Private declarations }
    procedure DoDidFinish(Image: TBitmap);
    procedure DoMessageListener(const Sender: TObject; const M: TMessage);
  public
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}
procedure TForm1.DoDidFinish(Image: TBitmap);
begin
  Image1.Bitmap.Assign(Image);
end;

procedure TForm1.DoMessageListener(const Sender: TObject; const M: TMessage);
begin
  if M is TMessageDidFinishTakingImageFromLibrary then
    Image1.Bitmap.Assign(TMessageDidFinishTakingImageFromLibrary(M).Value);
end;
procedure TForm1.SpeedButton1Click(Sender: TObject);
var Service: IFMXCameraService;
    Params : TParamsPhotoQuery;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXCameraService, Service) then
  begin
    Params.Editable := True;
    Params.NeedSaveToAlbum := True;
    Params.RequiredResolution := TSize.Create(640,640);
    Params.OnDidFinishTaking := DoDidFinish;
    Service.TakePhoto(SpeedButton1, Params);


  end
  else
  ShowMessage('This device does not support the camera service');

end;

///procedure TForm1.Button1Click(Sender: TObject);
//begin
//  Label1.Text := Edit1.Text;
//end;

end.
