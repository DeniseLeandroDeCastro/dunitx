unit uFrmIMC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Unit2, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edtPeso: TEdit;
    edtAltura: TEdit;
    btnCalcular: TButton;
    Label3: TLabel;
    edtIdade: TEdit;
    Label4: TLabel;
    edtIMC: TEdit;
    Label5: TLabel;
    edtClassificacao: TEdit;
    btnLimpar: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnCalcularClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLimparClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  oAvaliacao: TAvaliacao;

implementation

{$R *.dfm}

procedure TForm1.btnCalcularClick(Sender: TObject);
begin
  if ((edtPeso.Text <> EmptyStr) and (edtAltura.Text <> EmptyStr) and (edtIdade.Text <> EmptyStr)) then
  begin
    try
      oAvaliacao.Peso     := StrToFloat(edtPeso.Text);
      oAvaliacao.Altura   := StrToFloat(edtAltura.Text);
      oAvaliacao.Idade    := StrToInt(edtIdade.Text);
      oAvaliacao.IMC      := oAvaliacao.CalculaIMC(oAvaliacao.Altura,oAvaliacao.Peso,oAvaliacao.Idade);
      oAvaliacao.ClassIMC := oAvaliacao.RetornaClassificacaoIMC(oAvaliacao.IMC,oAvaliacao.Idade);

      edtIMC.Text           := FormatFloat('###,##0.00',oAvaliacao.IMC);
      edtClassificacao.Text := oAvaliacao.ClassIMC;
    except
      on e: EFaixaEtariaIndisponivel do
        ShowMessage(e.Message);
    end;
  end
  else
    ShowMessage('Dados obrigat�rios n�o preenchidos!');
end;

procedure TForm1.btnLimparClick(Sender: TObject);
begin
  edtPeso.Text := EmptyStr;
  edtAltura.Text := EmptyStr;
  edtIdade.Text := EmptyStr;
  edtIMC.Text := EmptyStr;
  edtClassificacao.Text := EmptyStr;
  edtPeso.SetFocus;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(oAvaliacao);
  Action := caFree;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  oAvaliacao := TAvaliacao.Create;
end;

end.
