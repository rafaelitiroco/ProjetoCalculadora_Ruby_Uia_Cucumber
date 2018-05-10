#encoding: utf-8

require 'magic_encoding'

class CalcPage < CalcLocators

  def start_calc
    cont = 0
    while Uia.find_element(title: "Calculadora").nil? == false and cont < 40
      sleep 0.3
      cont += 1
    end
    raise "Falha ao tentar abrir a calculadora" if Uia.find_element(title: "Calculadora").nil?
    $win = Uia.find_element(title: "Calculadora")
  end

  def click_button(btn)
    click_uia_button(btn_calc(btn), btn)
  end

  def verifica_result(result)
    raise "Resultado apresentado <#{frame_result.name}> é diferente do informado <#{result}>" if frame_result.name != result
  end

#######################################
#Metodos utilizando a planilha
  def click_button_sheet(btn)
    b = btn.size
    b.times do |x|
      click_uia_button(btn_calc(btn[x]), btn[x])
    end
  end

  def verifica_result_sheet(result)
    if frame_result.name == result
      alterar_status_planilha("PASSED")
    else
      alterar_status_planilha("FAILED")


      raise "Resultado apresentado <#{frame_result.name}> é diferente do informado <#{result}>"


    end
  end
#######################################

end