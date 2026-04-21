unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage, Vcl.Imaging.GIFImg, System.Math;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    Image1: TImage;
    Image2: TImage;
    OpenPictureDialog1: TOpenDialog;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    procedure Button1Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
  private
    FUpdatingN: Boolean;
    procedure ApplyMeanFilter;
  public
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

type
  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array[0..(MaxInt div SizeOf(TRGBTriple)) - 1] of TRGBTriple;

procedure TForm2.Button1Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    ApplyMeanFilter;
  end;
end;

procedure TForm2.SpinEdit1Change(Sender: TObject);
begin
  if FUpdatingN then
    Exit;

  if SpinEdit1.Value mod 2 = 0 then
  begin
    FUpdatingN := True;
    try
      SpinEdit1.Value := SpinEdit1.Value + 1;
    finally
      FUpdatingN := False;
    end;
  end;

  if Assigned(Image1.Picture.Graphic) and (not Image1.Picture.Graphic.Empty) then
    ApplyMeanFilter;
end;

procedure TForm2.ApplyMeanFilter;
var
  SrcBmp, DstBmp: TBitmap;
  X, Y, N, Radius: Integer;
  W, H, Stride, Area: Integer;
  X1, Y1, X2, Y2: Integer;
  SrcRow: PRGBTripleArray;
  DstRow: PRGBTripleArray;
  SumR, SumG, SumB: Int64;
  IntegralR, IntegralG, IntegralB: array of Int64;

  function Idx(AX, AY: Integer): Integer;
  begin
    Result := (AY * Stride) + AX;
  end;
begin
  if (not Assigned(Image1.Picture.Graphic)) or Image1.Picture.Graphic.Empty then
    Exit;

  N := SpinEdit1.Value;
  if N < 1 then
    N := 1;

  Radius := N div 2;

  Screen.Cursor := crHourGlass;
  SrcBmp := TBitmap.Create;
  DstBmp := TBitmap.Create;
  try
    SrcBmp.Assign(Image1.Picture.Graphic);
    SrcBmp.PixelFormat := pf24bit;

    W := SrcBmp.Width;
    H := SrcBmp.Height;
    if (W = 0) or (H = 0) then
      Exit;

    DstBmp.SetSize(W, H);
    DstBmp.PixelFormat := pf24bit;

    Stride := W + 1;
    SetLength(IntegralR, Stride * (H + 1));
    SetLength(IntegralG, Stride * (H + 1));
    SetLength(IntegralB, Stride * (H + 1));

    for Y := 1 to H do
    begin
      SrcRow := SrcBmp.ScanLine[Y - 1];
      for X := 1 to W do
      begin
        IntegralR[Idx(X, Y)] := IntegralR[Idx(X - 1, Y)] + IntegralR[Idx(X, Y - 1)] -
          IntegralR[Idx(X - 1, Y - 1)] + SrcRow[X - 1].rgbtRed;
        IntegralG[Idx(X, Y)] := IntegralG[Idx(X - 1, Y)] + IntegralG[Idx(X, Y - 1)] -
          IntegralG[Idx(X - 1, Y - 1)] + SrcRow[X - 1].rgbtGreen;
        IntegralB[Idx(X, Y)] := IntegralB[Idx(X - 1, Y)] + IntegralB[Idx(X, Y - 1)] -
          IntegralB[Idx(X - 1, Y - 1)] + SrcRow[X - 1].rgbtBlue;
      end;
    end;

    for Y := 0 to H - 1 do
    begin
      DstRow := DstBmp.ScanLine[Y];
      Y1 := Max(0, Y - Radius);
      Y2 := Min(H - 1, Y + Radius);

      for X := 0 to W - 1 do
      begin
        X1 := Max(0, X - Radius);
        X2 := Min(W - 1, X + Radius);

        Area := (X2 - X1 + 1) * (Y2 - Y1 + 1);

        SumR := IntegralR[Idx(X2 + 1, Y2 + 1)] - IntegralR[Idx(X1, Y2 + 1)] -
          IntegralR[Idx(X2 + 1, Y1)] + IntegralR[Idx(X1, Y1)];
        SumG := IntegralG[Idx(X2 + 1, Y2 + 1)] - IntegralG[Idx(X1, Y2 + 1)] -
          IntegralG[Idx(X2 + 1, Y1)] + IntegralG[Idx(X1, Y1)];
        SumB := IntegralB[Idx(X2 + 1, Y2 + 1)] - IntegralB[Idx(X1, Y2 + 1)] -
          IntegralB[Idx(X2 + 1, Y1)] + IntegralB[Idx(X1, Y1)];

        DstRow[X].rgbtRed := Byte(SumR div Area);
        DstRow[X].rgbtGreen := Byte(SumG div Area);
        DstRow[X].rgbtBlue := Byte(SumB div Area);
      end;
    end;

    Image2.Picture.Assign(DstBmp);
  finally
    Screen.Cursor := crDefault;
    SrcBmp.Free;
    DstBmp.Free;
  end;
end;

end.
