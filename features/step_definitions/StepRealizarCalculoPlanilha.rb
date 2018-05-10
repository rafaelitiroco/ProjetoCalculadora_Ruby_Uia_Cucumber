#encoding: utf-8

require './features/Pages/CalcPage'

calc = CalcPage.new

Dado(/^clicar no botão do primeiro valor$/) do
  fechar_processo_excel
  obter_dados_planilha
  puts "O valor selecionado foi o: " + $hash_massa_dados["valor_1"].to_i.to_s
  calc.click_button_sheet($hash_massa_dados["valor_1"].to_i.to_s)
  screenshot_desktop
end

E(/^clicar no botão de tipo de operação$/) do
  puts "A operação selecionada foi: " + $hash_massa_dados["operacao"].to_s
  calc.click_button_sheet($hash_massa_dados["operacao"])
  screenshot_desktop
end

E(/^clicar no primeiro botão do segundo valor$/) do
  puts "O valor selecionado foi o: " + $hash_massa_dados["valor_2"].to_i.to_s
  calc.click_button_sheet($hash_massa_dados["valor_2"].to_i.to_s)
  screenshot_desktop
end

Então(/^será apresentado na tela resultado o número$/) do
  puts "O resultado esperado é: " + $hash_massa_dados["resultado_esperado"].to_i.to_s
  calc.verifica_result_sheet($hash_massa_dados["resultado_esperado"].to_i.to_s)
  screenshot_desktop
  fechar_processo_excel
end