program Teste_madcal;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  module.tbPrecos in 'Querys\module.tbPrecos.pas',
  module.produtos in 'Querys\module.produtos.pas',
  module.contas in 'Querys\module.contas.pas',
  module.orcamento in 'Querys\module.orcamento.pas',
  utility in 'Utils\utility.pas',
  module.politica.precos in 'Querys\module.politica.precos.pas',
  module.itens in 'Querys\module.itens.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
