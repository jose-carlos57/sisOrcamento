unit module.tbPrecos;

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
  Vcl.ComCtrls, Vcl.Mask, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, System.JSON;



function InserirDados(FDConnection: TFDConnection; const descricaoTbPrecos: string; var cd_status: Integer): Boolean;
function buscarDadosComboBox(FDConnection: TFDConnection; combobox: TCombobox): boolean;
function verificarQuantidadeDados(FDConnection: TFDConnection): integer;
implementation

function InserirDados(FDConnection: TFDConnection; const descricaoTbPrecos: string; var cd_status: Integer): Boolean;
var
  FDQuery: TFDQuery;
begin

FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := FDConnection;
    FDQuery.SQL.Text := 'INSERT INTO tabela_de_precos (descricao_tabela_precos, cd_status) VALUES (:descricao_tabela_precos, :cd_status)';

    // Define os par�metros
    FDQuery.ParamByName('descricao_tabela_precos').AsString := descricaoTbPrecos;
    FDQuery.ParamByName('cd_status').AsInteger := cd_status;

    // Executa a query
     try
      FDQuery.ExecSQL;
      Result:= true;
    except
      ShowMessage('Erro ao inserir dados!')
    end;


  finally
    FDQuery.Free;
  end;
end;

function buscarDadosComboBox(FDConnection: TFDConnection; combobox: TCombobox):boolean;
var
  FDQuery: TFDQuery;
  objJsonItens: TJSONObject;

begin

  objJsonItens := TJSONObject.Create;

  FDQuery := TFDQuery.Create(nil);
  FDQuery.Connection := FDConnection;
  FDQuery.SQL.Text := 'SELECT * FROM tabela_de_precos WHERE cd_status = :cd_status'; //1 = ativo  0 = inativo
  FDQuery.ParamByName('cd_Status').AsInteger := 1;

  try
    FDQuery.Open;

    if not FDQuery.IsEmpty then
     begin
      while not FDQuery.Eof do
        begin
         Combobox.Items.AddObject(FDQuery.FieldByName('descricao_tabela_precos').AsString,
                       TObject(FDQuery.FieldByName('idTabela_de_precos').AsInteger));
         FDQuery.Next;
         end;
      end;
  finally

  end;
end;

function verificarQuantidadeDados(FDConnection: TFDConnection): integer;
var
  FDQuery: TFDQuery;
begin

FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := FDConnection;
    FDQuery.SQL.Text := 'SELECT COUNT(*) FROM tabela_de_precos';


  FDQuery.Open; // Executa a consulta
  Result := FDQuery.Fields[0].AsInteger; // Obt�m o resultado
  showmessage( intToStr(Result) );
  FDQuery.Close; // Fecha a consulta

  finally
    FDQuery.Free;
  end;
end;
end.
