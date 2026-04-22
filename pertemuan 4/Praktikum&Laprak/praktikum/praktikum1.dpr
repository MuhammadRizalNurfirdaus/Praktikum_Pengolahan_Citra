program praktikum1;

uses
  Vcl.Forms,
  kecermelangan in 'kecermelangan.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
