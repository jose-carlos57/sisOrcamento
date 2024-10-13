unit Main;

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
  module.itens,
  System.JSON, System.ImageList, Vcl.ImgList;

type
  TForm1 = class(TForm)
    pnlPrincipal: TPanel;
    pnlLateral: TPanel;
    pnlConteudo: TPanel;
    btnCadastro: TSpeedButton;
    btnLancamento: TSpeedButton;
    pnlTituloSistema: TPanel;
    pnlConteudoRotas: TPanel;
    pnlConteudoRotasCadastor: TPanel;
    pnlConteudoRotasLancamento: TPanel;
    PageControl1: TPageControl;
    edit: TTabSheet;
    cap: TTabSheet;
    ComboBoxTabelaDePreco: TComboBox;
    lblDescricaoProduto: TLabel;
    edtDescricaoProduto: TEdit;
    Label5: TLabel;
    edtUnidadeMedida: TEdit;
    Label4: TLabel;
    RadioProdutoAtivo: TRadioButton;
    RadioProdutoInativo: TRadioButton;
    cadastrarTbPreco: TButton;
    FDConnection1: TFDConnection;
    RadioTbPrecoAtivo: TRadioButton;
    RadiotbPrecoInativo: TRadioButton;
    lblStatusTablePreco: TLabel;
    boxTabeladeprecoProduto: TComboBox;
    lblTbprecoProduto: TLabel;
    lblPrecoTabele: TLabel;
    edtPrecoTabela: TEdit;
    lblTabelaPrecoOrcamento: TLabel;
    ComboBoxTabelaPreco: TComboBox;
    lblNomeClienteOrcamento: TLabel;
    Label2: TLabel;
    edtNomeClienteOrcamento: TEdit;
    MaskTelefoneCliente: TMaskEdit;
    Label1: TLabel;
    edtNomeVendedorOrcamento: TEdit;
    lblTelefoneVendedorOrcamento: TLabel;
    editTelefoneVendedor: TMaskEdit;
    lblTipoPagamento: TLabel;
    ComboBoxTipopagamento: TComboBox;
    lblDesconto: TLabel;
    edtDescontoOrcamento: TEdit;
    TabSheet3: TTabSheet;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label6: TLabel;
    Label10: TLabel;
    edtNomeConta: TEdit;
    edtApelidoConta: TEdit;
    maskTelefoneConta: TMaskEdit;
    comboboxTipoConta: TComboBox;
    RadioAtivoConta: TRadioButton;
    RadioInativoConta: TRadioButton;
    ButtonCadastrarConta: TButton;
    RadioTipoPessoa: TRadioGroup;
    ComboBoxSelecionarProdutos: TComboBox;
    lblListaprodutos: TLabel;
    btnlancarDesconto: TButton;
    cadastrar: TButton;
    ImageList1: TImageList;
    procedure btnCadastroClick(Sender: TObject);
    procedure btnLancamentoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cadastrarTbPrecoClick(Sender: TObject);
    procedure edtUnidadeMedidaKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrecoTabelaKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonCadastrarContaClick(Sender: TObject);
    procedure btnlancarDescontoClick(Sender: TObject);
    procedure ComboBoxTipopagamentoChange(Sender: TObject);
    procedure edtDescontoOrcamentoKeyPress(Sender: TObject; var Key: Char);



  private
    { Private declarations }
  public
    function validaRadioPessoa(radioTipoPesso: TradioGroup; var  tipo_pessoa: integer):boolean;
  end;

var
  Form1: TForm1;
  objDataComboBox: TJSONObject;

implementation

{$R *.dfm}


procedure TForm1.btnCadastroClick(Sender: TObject);
begin
      pnlConteudoRotasCadastor.Visible :=  true;
      pnlConteudoRotasLancamento.Visible := false
end;

procedure TForm1.btnLancamentoClick(Sender: TObject);
begin
      pnlConteudoRotasLancamento.Visible := true;
      pnlConteudoRotasCadastor.Visible :=  false;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
   descricaoTbPrecos: string;
   status: Integer;
begin
    module.tbPrecos.buscarDadosComboBox(FDConnection1, boxTabeladeprecoProduto); // refatorar depois atualizar todo vez que cadastrar

  if (ComboBoxTabelaDePreco.ItemIndex <> -1) and
      utility.capturaClick(RadioTbPrecoAtivo,RadioTbPrecoInativo,status) then
    begin
       descricaoTbPrecos := ComboBoxTabelaDePreco.Items[ComboBoxTabelaDePreco.ItemIndex];
       if module.tbPrecos.InserirDados(FDConnection1,descricaoTbPrecos, status) then
       begin
          ShowMessage('Cadastro realizado!');
          btnLancamento.Enabled := true;
          module.tbPrecos.buscarDadosComboBox(FDConnection1, boxTabeladeprecoProduto);
            module.tbPrecos.buscarDadosComboBox(FDConnection1, ComboBoxTabelaPreco);
       end;
    end
    else
     ShowMessage('Preencha todos os campos!')
  end;


procedure TForm1.btnlancarDescontoClick(Sender: TObject);
var
  id_retorno : integer;

  nomeCliente: string;
  telefoneCliente: string;
  nomeVendedor: string;
  telefoneVendedor: string;
  tipoPagamento: string;
  id_tabelaDePreco: integer;
  id_produto: integer;
  desconto: string;
begin
   if( (edtNomeClienteOrcamento.Text <> '' ) and
       (MaskTelefoneCliente.Text <> '' )    and
       (edtNomeVendedorOrcamento.Text <> '') and
       (editTelefoneVendedor.Text <> '') and
       (ComboBoxTipopagamento.ItemIndex <> -1) and
       (ComboBoxTabelaPreco.ItemIndex <> -1) and
       (ComboBoxSelecionarProdutos.ItemIndex <> -1)

     ) then
     begin
       try
        nomeCliente := edtNomeClienteOrcamento.Text;
        telefoneCliente := MaskTelefoneCliente.Text;
        nomeVendedor :=  edtNomeVendedorOrcamento.Text;
        telefoneVendedor := editTelefoneVendedor.Text;
        tipoPagamento :=   ComboBoxTipopagamento.Items[ComboBoxTipopagamento.ItemIndex];
        id_tabelaDePreco :=  utility.capturaValorIdCombobox(ComboBoxTabelaPreco);
        id_produto :=   utility.capturaValorIdCombobox(ComboBoxSelecionarProdutos);
        desconto :=   edtDescontoOrcamento.Text;
       except
          showMessage('Algo deu errado!')
       end;
        // INSERT e retorno de id

        id_retorno := module.orcamento.InserirDadosOrcamento(FDConnection1,
                        nomeCliente,telefoneCliente,nomeVendedor,telefoneVendedor,
                        tipoPagamento,id_tabelaDePreco,id_produto,desconto);

     if (id_retorno <> -1) then
        begin
           if(module.itens.inserrirItens(FDConnection1, id_retorno, id_produto)) then
           begin
              utility.clearFilds(Form1);
              Showmessage('Lan�amento realizado');
           end;
        end;
        end
     else
      Showmessage('Preencha todos os campos')
end;

procedure TForm1.ButtonCadastrarContaClick(Sender: TObject);

var

  nome: string;
  apelido: string;
  telefone : string;
  dataRadioTipoPessoa: integer;
  dataStatusConta: integer;
  tipoDeconta: string;
begin
  if(  edtNomeConta.Text <> '')
  and (edtApelidoConta.Text <> '')
  and (maskTelefoneConta.Text <> '')
  and ( comboboxTipoConta.ItemIndex <> -1 )
  and (utility.capturaClick(RadioAtivoConta, RadioInativoConta,dataStatusConta ))
  and (validaRadioPessoa(RadioTipoPessoa, dataRadioTipoPessoa)) then
    begin
      nome := edtNomeConta.Text;
      apelido := edtApelidoConta.Text;
      telefone := maskTelefoneConta.Text;
      tipoDeconta := comboboxTipoConta.Items[comboboxTipoConta.ItemIndex];

      if(module.contas.inserrirContas(FDConnection1, nome, apelido, telefone, tipoDeconta, dataRadioTipoPessoa,dataStatusConta))then
        begin
          ShowMessage('Cadastro concluido!');
            utility.clearFilds(Form1);
        end
    end
  else
  showmessage('Preencha todos os campos!')
end;

procedure TForm1.cadastrarTbPrecoClick(Sender: TObject);
var

  QntTbPreco : integer;

  idRecuperado: integer;
  descricao: string;
  unidadeMedida: double;
  preco: double;
  precoStr: string;

  status: Integer;
  idTabela_precos: Integer;


begin

    descricao :=  String(edtDescricaoProduto.Text);


  if ((descricao <> '')
      and (edtPrecoTabela.Text <> '' )
      and  (edtUnidadeMedida.Text <> '')
      and  (boxTabeladeprecoProduto.ItemIndex <> -1)
      and (utility.capturaClick(RadioProdutoAtivo,RadioProdutoInativo,status))) then
      begin

        unidadeMedida := strToFloat(StringReplace(edtUnidadeMedida.Text, '.', ',', [rfReplaceAll])); // tratar dado do campo
        idTabela_precos := utility.capturaValorIdCombobox(boxTabeladeprecoProduto);
        idRecuperado := module.produtos.inserirDadosProdutos(FDConnection1,descricao,unidadeMedida,status);
        preco :=     strToFloat(StringReplace(edtPrecoTabela.Text, '.', ',', [rfReplaceAll]));

          if(idRecuperado <> -1 ) then
             begin
              if(module.politica.precos.inserirPoliticaPreco(FDConnection1 ,idRecuperado, idTabela_precos, preco)) then
              begin
                //utility.clearFilds(Form1);
                ShowMessage('Cadastro de produto Realizado!');
                module.produtos.buscarDadosComboBoxProdutos(FDConnection1, ComboBoxSelecionarProdutos);
                  utility.clearFilds(Form1);
                end;
            end;
      end
      else
        ShowMessage('Preencha todos os Campos !')
  end;


procedure TForm1.ComboBoxTipopagamentoChange(Sender: TObject);
begin
 if(ComboBoxTipopagamento.Text = '� vista' ) then
  begin
    edtDescontoOrcamento.Enabled := true;

  end
  else
  edtDescontoOrcamento.Enabled := false;
end;

procedure TForm1.edtDescontoOrcamentoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9','.',',', #8]) then
    Key := #0;
end;

procedure TForm1.edtPrecoTabelaKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9','.',',', #8]) then
    Key := #0;
end;

procedure TForm1.edtUnidadeMedidaKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9','.',',', #8]) then
    Key := #0;
end;

procedure TForm1.FormCreate(Sender: TObject);
var QntTbPreco: integer;
begin
  pnlConteudoRotasCadastor.Visible :=  true;
  module.tbPrecos.buscarDadosComboBox(FDConnection1, boxTabeladeprecoProduto);
  module.tbPrecos.buscarDadosComboBox(FDConnection1, ComboBoxTabelaPreco);
  module.produtos.buscarDadosComboBoxProdutos(FDConnection1, ComboBoxSelecionarProdutos);
  edtDescontoOrcamento.Enabled := false;
  QntTbPreco :=   module.tbPrecos.verificarQuantidadeDados(FDConnection1);
  if(QntTbPreco < 1) then
    begin
         btnLancamento.Enabled := false;
    end
    else
         btnLancamento.Enabled := true;
end;




function TForm1.validaRadioPessoa(radioTipoPesso: TradioGroup;
  var tipo_pessoa: integer): boolean;
begin
if radioTipoPesso.ItemIndex = 0 then
  begin
      tipo_pessoa := 0;
  end
  else if radioTipoPesso.ItemIndex = 1 then
      tipo_pessoa := 1
  else
  begin
    Result := false;
  end;
end;

end.