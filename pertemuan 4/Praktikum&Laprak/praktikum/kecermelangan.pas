unit kecermelangan;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ExtDlgs,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.Imaging.GIFImg;

type
  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array[0..32767] of TRGBTriple;

  TForm2 = class(TForm)
    btnMuatCitra: TButton;
    lblMerah: TLabel;
    lblHijau: TLabel;
    lblBiru: TLabel;
    edtMerah: TEdit;
    edtHijau: TEdit;
    edtBiru: TEdit;
    chkSeragam: TCheckBox;
    btnProses: TButton;
    imgAsli: TImage;
    imgHasil: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure FormCreate(Sender: TObject);
    procedure btnMuatCitraClick(Sender: TObject);
    procedure btnProsesClick(Sender: TObject);
    procedure chkSeragamClick(Sender: TObject);
    procedure edtRGBChange(Sender: TObject);
  private
    function ClampByte(const Value: Integer): Byte;
    function TryReadOffsets(out OffsetR, OffsetG, OffsetB: Integer): Boolean;
    procedure ApplyBrightness;
  public
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  Caption := 'Modifikasi Kecemerlangan';
  edtMerah.Text := '0';
  edtHijau.Text := '0';
  edtBiru.Text := '0';
  chkSeragam.Checked := False;
end;

function TForm2.ClampByte(const Value: Integer): Byte;
begin
  if Value < 0 then
    Exit(0);

  if Value > 255 then
    Exit(255);

  Result := Value;
end;

function TForm2.TryReadOffsets(out OffsetR, OffsetG, OffsetB: Integer): Boolean;
begin
  Result := TryStrToInt(Trim(edtMerah.Text), OffsetR) and
            TryStrToInt(Trim(edtHijau.Text), OffsetG) and
            TryStrToInt(Trim(edtBiru.Text), OffsetB);

  if chkSeragam.Checked then
  begin
    OffsetG := OffsetR;
    OffsetB := OffsetR;
  end;
end;

procedure TForm2.ApplyBrightness;
var
  SourceBmp: TBitmap;
  ResultBmp: TBitmap;
  Row: Integer;
  Col: Integer;
  OffsetR: Integer;
  OffsetG: Integer;
  OffsetB: Integer;
  SrcLine: PRGBTripleArray;
  DstLine: PRGBTripleArray;
begin
  if imgAsli.Picture.Graphic = nil then
    Exit;

  if not TryReadOffsets(OffsetR, OffsetG, OffsetB) then
  begin
    ShowMessage('Nilai Merah, Hijau, dan Biru harus berupa bilangan bulat.');
    Exit;
  end;

  SourceBmp := TBitmap.Create;
  ResultBmp := TBitmap.Create;
  try
    SourceBmp.Assign(imgAsli.Picture.Graphic);
    SourceBmp.PixelFormat := pf24bit;

    ResultBmp.SetSize(SourceBmp.Width, SourceBmp.Height);
    ResultBmp.PixelFormat := pf24bit;

    for Row := 0 to SourceBmp.Height - 1 do
    begin
      SrcLine := SourceBmp.ScanLine[Row];
      DstLine := ResultBmp.ScanLine[Row];

      for Col := 0 to SourceBmp.Width - 1 do
      begin
        DstLine[Col].rgbtRed := ClampByte(SrcLine[Col].rgbtRed + OffsetR);
        DstLine[Col].rgbtGreen := ClampByte(SrcLine[Col].rgbtGreen + OffsetG);
        DstLine[Col].rgbtBlue := ClampByte(SrcLine[Col].rgbtBlue + OffsetB);
      end;
    end;

    imgHasil.Picture.Assign(ResultBmp);
  finally
    SourceBmp.Free;
    ResultBmp.Free;
  end;
end;

procedure TForm2.btnMuatCitraClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    imgAsli.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    ApplyBrightness;
  end;
end;

procedure TForm2.btnProsesClick(Sender: TObject);
begin
  ApplyBrightness;
end;

procedure TForm2.chkSeragamClick(Sender: TObject);
begin
  edtHijau.Enabled := not chkSeragam.Checked;
  edtBiru.Enabled := not chkSeragam.Checked;
  ApplyBrightness;
end;

procedure TForm2.edtRGBChange(Sender: TObject);
begin
  if imgAsli.Picture.Graphic <> nil then
    ApplyBrightness;
end;

end.
