unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, 
  Vcl.ComCtrls, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

type
  TForm2 = class(TForm)
    pnlMain: TPanel;
    pnlTop: TPanel;
    btnMuatCitra: TButton;
    lblTitle: TLabel;
    lblFactor1: TLabel;
    lblFactor2: TLabel;
    lblFactor3: TLabel;
    lblFactor4: TLabel;
    edtFactor: TEdit;
    btnFactor1: TButton;
    btnFactor2: TButton;
    btnFactor3: TButton;
    btnFactor4: TButton;
    btnProses: TButton;
    OpenDialog: TOpenDialog;
    pnlImages: TPanel;
    imgAsli: TImage;
    imgHasil: TImage;
    lblAsli: TLabel;
    lblHasil: TLabel;
    pnlAnalisis: TPanel;
    lblAnalisisTitle: TLabel;
    memoAnalisis: TMemo;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure btnMuatCitraClick(Sender: TObject);
    procedure btnProsesClick(Sender: TObject);
    procedure btnFactor1Click(Sender: TObject);
    procedure btnFactor2Click(Sender: TObject);
    procedure btnFactor3Click(Sender: TObject);
    procedure btnFactor4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FOriginalBitmap: TBitmap;
    FProcessedBitmap: TBitmap;
    FImageLoaded: Boolean;
    procedure IncreaseContrast(Source, Dest: TBitmap; Factor: Double);
    procedure LoadImage(const FileName: string);
    procedure ProcessWithFactor(Factor: Double);
    procedure UpdateAnalisis(Factor: Double);
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

type
  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array[0..32767] of TRGBTriple;

function TryParseFactor(const Text: string; out Factor: Double): Boolean;
var
  S: string;
  FS: TFormatSettings;
begin
  FS := TFormatSettings.Create;
  S := Trim(Text);

  Result := TryStrToFloat(S, Factor, FS);
  if Result then
    Exit;

  S := StringReplace(S, ',', FS.DecimalSeparator, [rfReplaceAll]);
  S := StringReplace(S, '.', FS.DecimalSeparator, [rfReplaceAll]);
  Result := TryStrToFloat(S, Factor, FS);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  FOriginalBitmap := TBitmap.Create;
  FProcessedBitmap := TBitmap.Create;
  FImageLoaded := False;
  
  edtFactor.Text := '1.50';
  
  OpenDialog.Filter := 'Semua Gambar|*.bmp;*.jpg;*.jpeg;*.png;*.gif|' +
                       'Gambar BMP (*.bmp)|*.bmp|' +
                       'Gambar JPG (*.jpg;*.jpeg)|*.jpg;*.jpeg|' +
                       'Gambar PNG (*.png)|*.png|' +
                       'Gambar GIF (*.gif)|*.gif|' +
                       'Semua File (*.*)|*.*';
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FOriginalBitmap);
  FreeAndNil(FProcessedBitmap);
end;

procedure TForm2.LoadImage(const FileName: string);
begin
  try
    if not FileExists(FileName) then
    begin
      ShowMessage('File tidak ditemukan: ' + FileName);
      Exit;
    end;
    
    // Load langsung ke Picture dan assign ke bitmap
    imgAsli.Picture.LoadFromFile(FileName);
    FOriginalBitmap.Assign(imgAsli.Picture.Graphic);
    FOriginalBitmap.PixelFormat := pf24bit;
    
    FImageLoaded := True;
    lblTitle.Caption := 'Peningkatan Kontras Citra - ' + ExtractFileName(FileName);
    
    memoAnalisis.Lines.Clear;
    memoAnalisis.Lines.Add('File dimuat: ' + ExtractFileName(FileName));
    memoAnalisis.Lines.Add('Ukuran: ' + IntToStr(FOriginalBitmap.Width) + ' x ' + 
                            IntToStr(FOriginalBitmap.Height) + ' piksel');
    memoAnalisis.Lines.Add('');
    memoAnalisis.Lines.Add('Silakan pilih faktor kontras dan klik tombol atau "Proses"');
    
  except
    on E: Exception do
    begin
      FImageLoaded := False;
      ShowMessage('Error: ' + E.Message);
      memoAnalisis.Lines.Clear;
      memoAnalisis.Lines.Add('Error: ' + E.Message);
    end;
  end;
end;

procedure TForm2.btnMuatCitraClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    LoadImage(OpenDialog.FileName);
  end;
end;

procedure TForm2.IncreaseContrast(Source, Dest: TBitmap; Factor: Double);
var
  X, Y: Integer;
  SourceRow, DestRow: PRGBTripleArray;
  R, G, B: Integer;
  NewR, NewG, NewB: Integer;
const
  MidPoint = 128;
begin
  if (Source = nil) or (Dest = nil) then
    raise Exception.Create('Bitmap belum siap diproses.');

  if Source.Empty then
    raise Exception.Create('Citra asli kosong.');

  Source.PixelFormat := pf24bit;
  Dest.SetSize(Source.Width, Source.Height);
  Dest.PixelFormat := pf24bit;

  for Y := 0 to Source.Height - 1 do
  begin
    SourceRow := Source.ScanLine[Y];
    DestRow := Dest.ScanLine[Y];

    for X := 0 to Source.Width - 1 do
    begin
      B := SourceRow[X].rgbtBlue;
      G := SourceRow[X].rgbtGreen;
      R := SourceRow[X].rgbtRed;

      NewR := Round((R - MidPoint) * Factor + MidPoint);
      NewG := Round((G - MidPoint) * Factor + MidPoint);
      NewB := Round((B - MidPoint) * Factor + MidPoint);

      if NewR > 255 then NewR := 255 else if NewR < 0 then NewR := 0;
      if NewG > 255 then NewG := 255 else if NewG < 0 then NewG := 0;
      if NewB > 255 then NewB := 255 else if NewB < 0 then NewB := 0;

      DestRow[X].rgbtBlue := Byte(NewB);
      DestRow[X].rgbtGreen := Byte(NewG);
      DestRow[X].rgbtRed := Byte(NewR);
    end;
  end;
end;

procedure TForm2.ProcessWithFactor(Factor: Double);
begin
  if not FImageLoaded then
  begin
    ShowMessage('Silakan muat gambar terlebih dahulu!');
    Exit;
  end;
  
  if (FOriginalBitmap.Width = 0) or (FOriginalBitmap.Height = 0) then
  begin
    ShowMessage('Gambar tidak valid!');
    Exit;
  end;
  
  try
    if Factor <= 0 then
    begin
      ShowMessage('Nilai faktor harus lebih dari 0!');
      Exit;
    end;
    
    edtFactor.Text := Format('%.2f', [Factor]);
    
    IncreaseContrast(FOriginalBitmap, FProcessedBitmap, Factor);
    imgHasil.Picture.Assign(FProcessedBitmap);
    
    UpdateAnalisis(Factor);
  except
    on E: Exception do
      ShowMessage('Error saat pemrosesan: ' + E.Message);
  end;
end;

procedure TForm2.UpdateAnalisis(Factor: Double);
var
  AnalisisText: string;
begin
  AnalisisText := Format('Analisis: Faktor %.2f', [Factor]) + #13#10;
  
  if Factor < 1.0 then
    AnalisisText := AnalisisText + 'Kontras berkurang, citra lebih flat.'
  else if Factor = 1.0 then
    AnalisisText := AnalisisText + 'Tidak ada perubahan kontras.'
  else if Factor < 1.5 then
    AnalisisText := AnalisisText + 'Kontras sedikit meningkat, detail mulai terlihat lebih jelas.'
  else if Factor < 2.0 then
    AnalisisText := AnalisisText + 'Kontras sedang meningkat, detail terlihat lebih terang/gelap.'
  else
    AnalisisText := AnalisisText + 'Kontras tinggi meningkat, detail sangat dramatis.' + #13#10 +
                    'Area gelap lebih gelap, area terang lebih terang.';
  
  memoAnalisis.Lines.Clear;
  memoAnalisis.Lines.Add(AnalisisText);
end;

procedure TForm2.btnProsesClick(Sender: TObject);
var
  Factor: Double;
begin
  if not TryParseFactor(edtFactor.Text, Factor) then
  begin
    ShowMessage('Input faktor tidak valid! Gunakan format: 1.50 atau 1,50');
    Exit;
  end;

  ProcessWithFactor(Factor);
end;

procedure TForm2.btnFactor1Click(Sender: TObject);
begin
  ProcessWithFactor(1.20);
end;

procedure TForm2.btnFactor2Click(Sender: TObject);
begin
  ProcessWithFactor(1.50);
end;

procedure TForm2.btnFactor3Click(Sender: TObject);
begin
  ProcessWithFactor(1.80);
end;

procedure TForm2.btnFactor4Click(Sender: TObject);
begin
  ProcessWithFactor(2.20);
end;

end.
