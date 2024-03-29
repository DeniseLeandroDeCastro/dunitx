unit TestUnit;

interface
uses
  DUnitX.TestFramework, Unit2;

type

  [TestFixture]
  TestTAvaliacao = class(TObject)
  strict private
    FAvaliacao: TAvaliacao;
  private
  public
    [Setup] //Cria o objeto FAvaliacao, que � inst�ncia da classe TAvaliacao
    procedure Setup;

    [TearDown] //Libera o espa�o de mem�ria alocado
    procedure TearDown;
    // Sample Methods
    // Simple single Test
    [Test]
    procedure TestCalculaIMC;

    [Test]
    procedure TestIMCIdadeMenor18;

    [TestCase('Test01','19,17, N�o Dispon�vel')]
    [TestCase('Test02','18,18, Abaixo do Peso')]
    [TestCase('Test03','22,22,Peso Normal')]
    [TestCase('Test04','25,35,Sobrepeso')]
    [TestCase('Test05','30,35,Obesidade I')]
    [TestCase('Test06','39,59,Obesidade II')]
    [TestCase('Test07','40,59,Obesidade III')]
    [TestCase('Test08','21,60,Abaixo do Peso')]
    [TestCase('Test09','22,60,Peso Normal')]
    [TestCase('Test10','27,60,Acima do Peso')]
    procedure TestRetornaClassificacaoIMC(pIMC: Currency; pIdade: Integer; _Result: string);
  end;

implementation

procedure TestTAvaliacao.Setup;
begin
  FAvaliacao:=TAvaliacao.Create;
end;

procedure TestTAvaliacao.TearDown;
begin
  FAvaliacao.Free;
  FAvaliacao:=nil;
end;

procedure TestTAvaliacao.TestCalculaIMC;
var R: Extended;
begin
  R:=FAvaliacao.CalculaIMC(1.77, 80, 29);
  Assert.AreEqual(25.54, R);
end;

procedure TestTAvaliacao.TestIMCIdadeMenor18;
begin
  Assert.WillRaise(procedure
                   begin
                     FAvaliacao.CalculaIMC(1.77,80,18)
                   end,EFaixaEtariaIndisponivel);
end;

procedure TestTAvaliacao.TestRetornaClassificacaoIMC(pIMC: Currency; pIdade: Integer; _Result: string);
begin
end;

initialization
  TDUnitX.RegisterTestFixture(TestTAvaliacao);
end.
