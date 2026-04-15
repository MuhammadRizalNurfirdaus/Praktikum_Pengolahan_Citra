unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ExtDlgs, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage;

type
  TForm2 = class(TForm)
    ButtonMuatCitra: TButton;
    ButtonRerata: TButton;
    Image1: TImage;
    Image2: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure ButtonMuatCitraClick(Sender: TObject);
    procedure ButtonRerataClick(Sender: TObject);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.ButtonMuatCitraClick(Sender: TObject);
var
  SrcPicture: TPicture;
  Bmp: TBitmap;
begin
  if OpenPictureDialog1.Execute then
  begin
    SrcPicture := TPicture.Create;
    Bmp := TBitmap.Create;
    try
      SrcPicture.LoadFromFile(OpenPictureDialog1.FileName);
      Bmp.Assign(SrcPicture.Graphic);
      Bmp.PixelFormat := pf24bit;
      Image1.Picture.Bitmap.Assign(Bmp);
      Image2.Picture.Bitmap.Assign(Bmp);
      Image2.Picture.Bitmap.PixelFormat := pf24bit;
      Image1.Repaint;
      Image2.Repaint;
    except
      on E: Exception do
        ShowMessage('Gagal memuat citra: ' + E.Message);
    end;
    Bmp.Free;
    SrcPicture.Free;
  end;
end;

procedure TForm2.ButtonRerataClick(Sender: TObject);
var
  PC, PH: PByteArray;
  X, Y: Integer;
  R, G, B, K: Byte;
begin
  if Image1.Picture.Bitmap.Empty then
  begin
    ShowMessage('Muat citra terlebih dahulu.');
    Exit;
  end;

  Image1.Picture.Bitmap.PixelFormat := pf24bit;
  Image2.Picture.Bitmap.Assign(Image1.Picture.Bitmap);
  Image2.Picture.Bitmap.PixelFormat := pf24bit;

  for Y := 0 to Image1.Picture.Bitmap.Height - 1 do
  begin
    PC := Image1.Picture.Bitmap.ScanLine[Y];
    PH := Image2.Picture.Bitmap.ScanLine[Y];
    for X := 0 to Image1.Picture.Bitmap.Width - 1 do
    begin
      R := PC[3 * X + 2];
      G := PC[3 * X + 1];
      B := PC[3 * X];
      K := Round((Integer(R) + Integer(G) + Integer(B)) / 3);
      PH[3 * X + 2] := K;
      PH[3 * X + 1] := K;
      PH[3 * X] := K;
    end;
  end;

  Image2.Repaint;
end;

end.
