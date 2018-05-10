#language: pt
#encoding: utf-8

@executa_tudo_teste
Funcionalidade: Realizar Calculos da Planilha

  Contexto:
    Dado que abra a calculadora

  @RealizarSomaPlanilha
  Cenário: Realizar Calculos
    Dado clicar no botão do primeiro valor
    E clicar no botão de tipo de operação
    E clicar no primeiro botão do segundo valor
    Quando clicar no botão "="
    Então será apresentado na tela resultado o número