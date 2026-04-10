unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TForm2 = class(TForm)
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
var
  ImageFileName: string;
begin
  ImageFileName := ExpandFileName(ExtractFilePath(ParamStr(0)) + '..\..\AA.bmp');
  if not FileExists(ImageFileName) then
    ImageFileName := ExpandFileName(ExtractFilePath(ParamStr(0)) + '..\..\bayi.jpg');
  if FileExists(ImageFileName) then
    Image1.Picture.LoadFromFile(ImageFileName);
end;

end.
