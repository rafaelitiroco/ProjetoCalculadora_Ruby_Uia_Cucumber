#language: pt
#encoding: utf-8

@executa_tudo_teste
Funcionalidade: Realizar Calculos

  Contexto:
    Dado que abra a calculadora

  @RealizaSoma
  Cenário: Realizar Soma
    Dado clicar no botão "1"
    E clicar no botão "+"
    E clicar no botão "1"
    Quando clicar no botão "="
    Então será apresentado na tela resultado o número "2"
