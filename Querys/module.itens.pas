unit module.itens;

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
  module.contas,
  module.orcamento,
  System.JSON;

function inserrirItens(FDConnection:TFDConnection; id_orcamento: integer ; id_produto: integer ): boolean;
implementation

function inserrirItens(FDConnection:TFDConnection; id_orcamento: integer ; id_produto: integer ): boolean;
begin
  Var FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := FDConnection;
    FDQuery.SQL.Text := 'INSERT INTO itens (id_orcamento, id_produtos) VALUES (:id_orcamento, :id_Produtos)';

    // Define os par�metros
    FDQuery.ParamByName('id_orcamento').AsInteger := id_orcamento;
    FDQuery.ParamByName('id_Produtos').AsInteger := id_produto;

    // Executa a query
    try
      FDQuery.ExecSQL;
      Result:= true;
    except
      ShowMessage('Erro ao inserir dados itens!')
    end;
  finally
    FDQuery.Free;
  end;
end;
end;


end.