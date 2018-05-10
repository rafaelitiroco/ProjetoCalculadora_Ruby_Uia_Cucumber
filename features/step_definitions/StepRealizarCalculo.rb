#encoding: utf-8

require './features/Pages/CalcPage'

calc = CalcPage.new

Dado(/^que abra a calculadora$/) do
  calc.start_calc
  screenshot_desktop
end

Dado(/^clicar no botão "([^"]*)"$/) do |btn|
  calc.click_button(btn)
  screenshot_desktop
end

Então(/^será apresentado na tela resultado o número "([^"]*)"$/) do |result|
  calc.verifica_result(result)
  screenshot_desktop
end
