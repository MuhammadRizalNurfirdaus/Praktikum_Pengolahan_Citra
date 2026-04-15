unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ExtDlgs, Vcl.Menus, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    MainMenu1: TMainMenu;
    FileMenu: TMenuItem;
    ProcessMenu: TMenuItem;
    HelpMenu: TMenuItem;
    MenuLoadImage: TMenuItem;
    MenuSaveImage: TMenuItem;
    MenuExit: TMenuItem;
    MenuNegative: TMenuItem;
    MenuGrayscale: TMenuItem;
    MenuAbout: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    N1: TMenuItem;
    procedure MenuLoadImageClick(Sender: TObject);
    procedure MenuSaveImageClick(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
    procedure MenuNegativeClick(Sender: TObject);
    procedure MenuGrayscaleClick(Sender: TObject);
    procedure MenuAboutClick(Sender: TObject);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.MenuLoadImageClick(Sender: TObject);
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

procedure TForm2.MenuNegativeClick(Sender: TObject);
var
  PC, PH: PByteArray;
  X, Y: Integer;
  R, G, B: Byte;
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
      PH[3 * X + 2] := 255 - R;
      PH[3 * X + 1] := 255 - G;
      PH[3 * X] := 255 - B;
    end;
  end;

  Image2.Repaint;
end;

procedure TForm2.MenuSaveImageClick(Sender: TObject);
begin
  if Image2.Picture.Bitmap.Empty then
  begin
    ShowMessage('Proses citra terlebih dahulu sebelum menyimpan.');
    Exit;
  end;

  SavePictureDialog1.FileName := 'hasil_proses';
  if SavePictureDialog1.Execute then
  begin
    try
      Image2.Picture.Bitmap.SaveToFile(SavePictureDialog1.FileName);
      ShowMessage('Citra berhasil disimpan: ' + SavePictureDialog1.FileName);
    except
      on E: Exception do
        ShowMessage('Gagal menyimpan citra: ' + E.Message);
    end;
  end;
end;

procedure TForm2.MenuExitClick(Sender: TObject);
begin
  Close;
end;

procedure TForm2.MenuGrayscaleClick(Sender: TObject);
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
  ShowMessage('Konversi ke skala keabuan selesai.');
end;

procedure TForm2.MenuAboutClick(Sender: TObject);
begin
  ShowMessage('Aplikasi Pengolahan Citra' + #13#10 +
             'Praktikum 3 - Citra Negatif' + #13#10 +
             'Versi 1.0' + #13#10#13#10 +
             'Fitur: Load Image, Citra Negatif, Skala Keabuan, Save Result');
end;

end.
