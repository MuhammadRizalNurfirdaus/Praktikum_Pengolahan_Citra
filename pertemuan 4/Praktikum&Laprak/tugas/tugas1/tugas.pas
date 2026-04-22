unit tugas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.Imaging.GIFImg;

type
  TForm2 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    ImgAsli: TImage;
    ImgBaru: TImage;
    BvlAsli: TBevel;
    BvlBaru: TBevel;
    BtnMuat: TButton;
    BtnProses: TButton;
    BtnPlus20: TButton;
    BtnPlus50: TButton;
    BtnPlus100: TButton;
    LblMerah: TLabel;
    LblHijau: TLabel;
    LblBiru: TLabel;
    LblBaru: TLabel;
    LblAsli: TLabel;
    LblInfo: TLabel;
    EdtMerah: TEdit;
    EdtHijau: TEdit;
    EdtBiru: TEdit;
    CbSeragam: TCheckBox;
    OpenDialog1: TOpenDialog;

    procedure MuatCitra(Sender: TObject);
    procedure ProsesKlik(Sender: TObject);
    procedure UjiPreset(Sender: TObject);
    procedure ToggleSeragam(Sender: TObject);
    procedure TingkatkanKecerahan(const DeltaR, DeltaG, DeltaB: Integer);
    function ClampByte(const V: Integer): Byte;
    function BacaNilai(const EditCtrl: TEdit; const Nama: string; out Nilai: Integer): Boolean;
    procedure TulisAnalisis(const DeltaR, DeltaG, DeltaB: Integer);
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  Caption := 'Modifikasi Kecerahan Citra';
  Width := 940;
  Height := 520;
  BorderStyle := bsSingle;
  Position := poScreenCenter;

  BtnMuat := TButton.Create(Self);
  BtnMuat.Parent := Self;
  BtnMuat.Caption := 'Muat Citra';
  BtnMuat.SetBounds(20, 16, 100, 28);
  BtnMuat.OnClick := MuatCitra;

  LblMerah := TLabel.Create(Self);
  LblMerah.Parent := Self;
  LblMerah.Caption := 'Merah';
  LblMerah.SetBounds(140, 20, 45, 18);

  EdtMerah := TEdit.Create(Self);
  EdtMerah.Parent := Self;
  EdtMerah.Text := '20';
  EdtMerah.SetBounds(190, 17, 55, 23);

  LblHijau := TLabel.Create(Self);
  LblHijau.Parent := Self;
  LblHijau.Caption := 'Hijau';
  LblHijau.SetBounds(255, 20, 40, 18);

  EdtHijau := TEdit.Create(Self);
  EdtHijau.Parent := Self;
  EdtHijau.Text := '20';
  EdtHijau.SetBounds(300, 17, 55, 23);

  LblBiru := TLabel.Create(Self);
  LblBiru.Parent := Self;
  LblBiru.Caption := 'Biru';
  LblBiru.SetBounds(365, 20, 30, 18);

  EdtBiru := TEdit.Create(Self);
  EdtBiru.Parent := Self;
  EdtBiru.Text := '20';
  EdtBiru.SetBounds(400, 17, 55, 23);

  CbSeragam := TCheckBox.Create(Self);
  CbSeragam.Parent := Self;
  CbSeragam.Caption := 'Seragam';
  CbSeragam.Checked := True;
  CbSeragam.SetBounds(470, 19, 80, 20);
  CbSeragam.OnClick := ToggleSeragam;

  BtnProses := TButton.Create(Self);
  BtnProses.Parent := Self;
  BtnProses.Caption := 'Proses';
  BtnProses.SetBounds(560, 16, 80, 28);
  BtnProses.OnClick := ProsesKlik;

  BtnPlus20 := TButton.Create(Self);
  BtnPlus20.Parent := Self;
  BtnPlus20.Caption := '+20';
  BtnPlus20.SetBounds(655, 16, 55, 28);
  BtnPlus20.OnClick := UjiPreset;

  BtnPlus50 := TButton.Create(Self);
  BtnPlus50.Parent := Self;
  BtnPlus50.Caption := '+50';
  BtnPlus50.SetBounds(715, 16, 55, 28);
  BtnPlus50.OnClick := UjiPreset;

  BtnPlus100 := TButton.Create(Self);
  BtnPlus100.Parent := Self;
  BtnPlus100.Caption := '+100';
  BtnPlus100.SetBounds(775, 16, 60, 28);
  BtnPlus100.OnClick := UjiPreset;

  LblAsli := TLabel.Create(Self);
  LblAsli.Parent := Self;
  LblAsli.Caption := 'Asli';
  LblAsli.SetBounds(24, 55, 28, 18);

  LblBaru := TLabel.Create(Self);
  LblBaru.Parent := Self;
  LblBaru.Caption := 'Baru';
  LblBaru.SetBounds(468, 55, 30, 18);

  BvlAsli := TBevel.Create(Self);
  BvlAsli.Parent := Self;
  BvlAsli.Shape := bsBox;
  BvlAsli.SetBounds(20, 75, 420, 360);

  BvlBaru := TBevel.Create(Self);
  BvlBaru.Parent := Self;
  BvlBaru.Shape := bsBox;
  BvlBaru.SetBounds(460, 75, 420, 360);

  ImgAsli := TImage.Create(Self);
  ImgAsli.Parent := Self;
  ImgAsli.SetBounds(24, 79, 412, 352);
  ImgAsli.Stretch := True;
  ImgAsli.Proportional := True;
  ImgAsli.Center := True;

  ImgBaru := TImage.Create(Self);
  ImgBaru.Parent := Self;
  ImgBaru.SetBounds(464, 79, 412, 352);
  ImgBaru.Stretch := True;
  ImgBaru.Proportional := True;
  ImgBaru.Center := True;

  LblInfo := TLabel.Create(Self);
  LblInfo.Parent := Self;
  LblInfo.SetBounds(20, 444, 860, 40);
  LblInfo.WordWrap := True;
  LblInfo.Caption := 'Analisis: muat citra, lalu uji +20, +50, +100 untuk melihat perubahan kecerahan.';

  OpenDialog1 := TOpenDialog.Create(Self);
  OpenDialog1.Filter :=
    'File Citra|*.bmp;*.jpg;*.jpeg;*.png|Bitmap|*.bmp|JPEG|*.jpg;*.jpeg|PNG|*.png|Semua File|*.*';

  ToggleSeragam(nil);
end;

function TForm2.ClampByte(const V: Integer): Byte;
begin
  if V < 0 then
    Result := 0
  else if V > 255 then
    Result := 255
  else
    Result := V;
end;

procedure TForm2.MuatCitra(Sender: TObject);
var
  Ext: string;
  Bmp: TBitmap;
  Jpg: TJPEGImage;
  Png: TPngImage;
  Gif: TGIFImage;
begin
  if OpenDialog1.Execute then
  begin
    Ext := LowerCase(ExtractFileExt(OpenDialog1.FileName));
    try
      if Ext = '.bmp' then
      begin
        Bmp := TBitmap.Create;
        try
          Bmp.LoadFromFile(OpenDialog1.FileName);
          ImgAsli.Picture.Assign(Bmp);
        finally
          Bmp.Free;
        end;
      end
      else if (Ext = '.jpg') or (Ext = '.jpeg') then
      begin
        Jpg := TJPEGImage.Create;
        try
          Jpg.LoadFromFile(OpenDialog1.FileName);
          ImgAsli.Picture.Assign(Jpg);
        finally
          Jpg.Free;
        end;
      end
      else if Ext = '.png' then
      begin
        Png := TPngImage.Create;
        try
          Png.LoadFromFile(OpenDialog1.FileName);
          ImgAsli.Picture.Assign(Png);
        finally
          Png.Free;
        end;
      end
      else if Ext = '.gif' then
      begin
        Gif := TGIFImage.Create;
        try
          Gif.LoadFromFile(OpenDialog1.FileName);
          ImgAsli.Picture.Assign(Gif);
        finally
          Gif.Free;
        end;
      end
      else
      begin
        ShowMessage('Format belum didukung: ' + Ext);
        Exit;
      end;

      ImgBaru.Picture.Assign(ImgAsli.Picture);
      LblInfo.Caption := 'Citra dimuat: ' + ExtractFileName(OpenDialog1.FileName) +
        '. Silakan proses dengan +20, +50, atau +100.';
    except
      on E: Exception do
        ShowMessage('Gagal memuat citra: ' + E.Message);
    end;
  end;
end;

procedure TForm2.ToggleSeragam(Sender: TObject);
begin
  EdtHijau.Enabled := not CbSeragam.Checked;
  EdtBiru.Enabled := not CbSeragam.Checked;
  if CbSeragam.Checked then
  begin
    EdtHijau.Text := EdtMerah.Text;
    EdtBiru.Text := EdtMerah.Text;
  end;
end;

procedure TForm2.TingkatkanKecerahan(const DeltaR, DeltaG, DeltaB: Integer);
type
  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array[0..32767] of TRGBTriple;
var
  BmpSrc, BmpDst: TBitmap;
  X, Y: Integer;
  SrcRow, DstRow: PRGBTripleArray;
begin
  if (ImgAsli.Picture.Graphic = nil) or ImgAsli.Picture.Graphic.Empty then
  begin
    ShowMessage('Muat citra terlebih dahulu.');
    Exit;
  end;

  BmpSrc := TBitmap.Create;
  BmpDst := TBitmap.Create;
  try
    BmpSrc.SetSize(ImgAsli.Picture.Width, ImgAsli.Picture.Height);
    BmpSrc.PixelFormat := pf24bit;
    BmpSrc.Canvas.Brush.Color := clWhite;
    BmpSrc.Canvas.FillRect(Rect(0, 0, BmpSrc.Width, BmpSrc.Height));
    BmpSrc.Canvas.Draw(0, 0, ImgAsli.Picture.Graphic);

    BmpDst.SetSize(BmpSrc.Width, BmpSrc.Height);
    BmpDst.PixelFormat := pf24bit;

    for Y := 0 to BmpSrc.Height - 1 do
    begin
      SrcRow := BmpSrc.ScanLine[Y];
      DstRow := BmpDst.ScanLine[Y];
      for X := 0 to BmpSrc.Width - 1 do
      begin
        DstRow[X].rgbtRed := ClampByte(SrcRow[X].rgbtRed + DeltaR);
        DstRow[X].rgbtGreen := ClampByte(SrcRow[X].rgbtGreen + DeltaG);
        DstRow[X].rgbtBlue := ClampByte(SrcRow[X].rgbtBlue + DeltaB);
      end;
    end;

    ImgBaru.Picture.Assign(BmpDst);
  finally
    BmpDst.Free;
    BmpSrc.Free;
  end;
end;

function TForm2.BacaNilai(const EditCtrl: TEdit; const Nama: string; out Nilai: Integer): Boolean;
begin
  Result := TryStrToInt(Trim(EditCtrl.Text), Nilai);
  if not Result then
    ShowMessage('Nilai ' + Nama + ' harus berupa integer.');
end;

procedure TForm2.TulisAnalisis(const DeltaR, DeltaG, DeltaB: Integer);
begin
  if (DeltaR = DeltaG) and (DeltaG = DeltaB) then
  begin
    if DeltaR <= 20 then
      LblInfo.Caption := 'Analisis: +' + IntToStr(DeltaR) +
        ' membuat citra sedikit lebih terang, detail masih terjaga.'
    else if DeltaR <= 50 then
      LblInfo.Caption := 'Analisis: +' + IntToStr(DeltaR) +
        ' memberi perubahan jelas; area terang mulai kehilangan detail.'
    else
      LblInfo.Caption := 'Analisis: +' + IntToStr(DeltaR) +
        ' sangat terang; banyak piksel mencapai 255 (clipping/saturasi).';
  end
  else
    LblInfo.Caption := 'Analisis: penambahan RGB berbeda (R=' + IntToStr(DeltaR) +
      ', G=' + IntToStr(DeltaG) + ', B=' + IntToStr(DeltaB) +
      ') mengubah kecerahan sekaligus nuansa warna citra.';
end;

procedure TForm2.ProsesKlik(Sender: TObject);
var
  DeltaR, DeltaG, DeltaB: Integer;
begin
  if not BacaNilai(EdtMerah, 'Merah', DeltaR) then
    Exit;

  if CbSeragam.Checked then
  begin
    DeltaG := DeltaR;
    DeltaB := DeltaR;
    EdtHijau.Text := IntToStr(DeltaR);
    EdtBiru.Text := IntToStr(DeltaR);
  end
  else
  begin
    if not BacaNilai(EdtHijau, 'Hijau', DeltaG) then
      Exit;
    if not BacaNilai(EdtBiru, 'Biru', DeltaB) then
      Exit;
  end;

  if (DeltaR < -255) or (DeltaR > 255) or (DeltaG < -255) or (DeltaG > 255) or
     (DeltaB < -255) or (DeltaB > 255) then
  begin
    ShowMessage('Rentang nilai yang disarankan adalah -255 sampai 255.');
    Exit;
  end;

  TingkatkanKecerahan(DeltaR, DeltaG, DeltaB);
  TulisAnalisis(DeltaR, DeltaG, DeltaB);
end;

procedure TForm2.UjiPreset(Sender: TObject);
var
  Delta: Integer;
begin
  if Sender = BtnPlus20 then
    Delta := 20
  else if Sender = BtnPlus50 then
    Delta := 50
  else
    Delta := 100;

  CbSeragam.Checked := True;
  ToggleSeragam(nil);
  EdtMerah.Text := IntToStr(Delta);
  EdtHijau.Text := IntToStr(Delta);
  EdtBiru.Text := IntToStr(Delta);

  TingkatkanKecerahan(Delta, Delta, Delta);
  TulisAnalisis(Delta, Delta, Delta);
end;

end.
