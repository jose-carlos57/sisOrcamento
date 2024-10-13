unit module.contas;

interface
uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.StdCtrls,
  Vcl.CheckLst,
  Vcl.ComCtrls,
  Vcl.Mask,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  module.tbPrecos,
  module.produtos,
  module.politica.precos,
  utility,
  System.JSON;

function inserrirContas(FDConnection:TFDConnection;  var nome: string; var apelido: string; var telefone: string; var tipo_conta:string;var tipo_pessoa: integer ;var cd_status: Integer): boolean;

implementation

function inserrirContas(FDConnection:TFDConnection;  var nome: string; var apelido: string; var telefone: string; var tipo_conta:string;var tipo_pessoa: integer ;var cd_status: Integer): boolean;
begin
  Var FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := FDConnection;
    FDQuery.SQL.Text := 'INSERT INTO contas (nome, telefone, apelido, tipo_conta, tipo_pessoa, cd_status) VALUES (:nome, :telefone, :apelido, :tipo_conta, :tipo_pessoa, :cd_status)';

    // Define os par�metros
    FDQuery.ParamByName('nome').AsString := nome;
    FDQuery.ParamByName('telefone').AsString := telefone;
    FDQuery.ParamByName('apelido').AsString := apelido;
    FDQuery.ParamByName('tipo_conta').AsString := tipo_conta;
    FDQuery.ParamByName('tipo_pessoa').AsInteger := tipo_pessoa;
    FDQuery.ParamByName('cd_status').AsInteger := cd_status;

    // Executa a query
    try
      FDQuery.ExecSQL;
      Result:= true;
    except
      ShowMessage('Erro ao inserir dados Cantas!')
    end;
  finally
    FDQuery.Free;
  end;
end;
end;

end.