unit module.politica.precos;

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
  utility,
  System.JSON;


function inserirPoliticaPreco(FDConnection:TFDConnection; var id_produto: integer; var id_tabela_preco: integer ; var preco: double): boolean;

implementation
function inserirPoliticaPreco(FDConnection:TFDConnection; var id_produto: integer; var id_tabela_preco: integer ; var preco: double): boolean;
Var FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := FDConnection;
    FDQuery.SQL.Text := 'INSERT INTO politica_de_precos (idTabela_de_precos, id_Produtos, Preco) VALUES (:idTabela_de_precos, :id_Produtos, :Preco)';

    // Define os parâmetros
    FDQuery.ParamByName('idTabela_de_precos').AsInteger := id_tabela_preco ;
    FDQuery.ParamByName('id_Produtos').AsInteger := id_produto;
    FDQuery.ParamByName('Preco').AsFloat := Preco;

    // Executa a query
    try
      FDQuery.ExecSQL;
      Result:= true;
    except
      ShowMessage('Erro ao inserir dados politica de preços!')
    end;
  finally
    FDQuery.Free;
  end;
end;

end.

