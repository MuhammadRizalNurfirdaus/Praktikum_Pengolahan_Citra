unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    ButtonMuatCitra: TButton;
    LabelPosisi: TLabel;
    LabelMerah: TLabel;
    LabelHijau: TLabel;
    LabelBiru: TLabel;
    EditR: TEdit;
    EditG: TEdit;
    EditB: TEdit;
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure ButtonMuatCitraClick(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.ButtonMuatCitraClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    Image1.Picture.Bitmap.PixelFormat := pf24bit;
  end;
end;

procedure TForm2.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  PC: PByteArray;
  R, G, B: byte;
begin
  if Image1.Picture.Bitmap.PixelFormat = pf24bit then
  begin
    if (X >= 0) and (Y >= 0) and
      (X < Image1.Picture.Bitmap.Width) and (Y < Image1.Picture.Bitmap.Height) then
    begin
      PC := Image1.Picture.Bitmap.ScanLine[Y];
      R := PC[3 * X + 2];
      G := PC[3 * X + 1];
      B := PC[3 * X];
      LabelPosisi.Caption := 'Posisi: (' + IntToStr(X) + ',' + IntToStr(Y) + ')';
      EditR.Text := IntToStr(R);
      EditG.Text := IntToStr(G);
      EditB.Text := IntToStr(B);
    end;
  end;
end;

end.
