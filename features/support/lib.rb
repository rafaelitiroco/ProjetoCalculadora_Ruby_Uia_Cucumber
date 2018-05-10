################################################################################################################
# METODOS PARA MANIPULACAO DA PLANILHA
################################################################################################################

#FECHAR PROCESSO DO EXCEL
def fechar_processo_excel
  t1 = Thread.new{
    require 'win32ole'
    wmi = WIN32OLE.connect("winmgmts://")
    processos = wmi.ExecQuery("Select * from Win32_Process Where NAME = 'EXCEL.EXE'")
    processos.each do |processo|
      Process.kill('KILL', processo.ProcessID.to_i)
    end
  }
  t1.join
end

def obter_dados_planilha
  t1 = Thread.new{
    require 'win32ole'
    #ABRIR PLANILHA EXCEL
    $excel = WIN32OLE.new('Excel.Application')
    workbook = $excel.Workbooks.Open('C:\ProjetoCalculadora_Ruby_Uia_Cucumber\DataTable\datatable')
    $excel.Visible = false
    $ws = workbook.Worksheets 1

    #LEITURA DE PLANILHA COM CRIACAO DE INDICE DINAMICO POR LINHA
    status_hash = false
    $hash_massa_dados = Hash.new
    for row in 1..$ws.UsedRange.Rows.Count do
      for col in 2..$ws.UsedRange.Columns.Count do
        if $ws.Cells(row,1).Value == nil
          $hash_massa_dados[$ws.Cells(1, col).Value.to_s.strip] = $ws.Cells(row, col).Value.to_s.strip
          status_hash = true
        end
      end
      break if status_hash
      if status_hash == false and row == $ws.UsedRange.Rows.Count


        raise "Quantidade de massa de dados insuficiente para execução de mais teste."


      end
    end
    $status_exec_sheet = row
    $ws.Cells(row,1).Value = Time.now.strftime("%d/%m/%Y %H:%M")
    $excel.AlertBeforeOverwriting = false
    $excel.DisplayAlerts = false
    $excel.Save
    $excel.Quit()
  }
  t1.join
end

def alterar_status_planilha(desc)
  t1 = Thread.new{
    require 'win32ole'
    #ABRIR PLANILHA EXCEL
    $excel = WIN32OLE.new('Excel.Application')
    workbook = $excel.Workbooks.Open('C:\ProjetoCalculadora_Ruby_Uia_Cucumber\DataTable\datatable')
    $excel.Visible = false
    $ws = workbook.Worksheets 1
    for col in 1..$ws.UsedRange.Columns.Count do
      if $ws.Cells(1,col).Value == "status_execucao"
        $ws.Cells($status_exec_sheet,col).Value = desc
      end
    end
    $excel.AlertBeforeOverwriting = false
    $excel.DisplayAlerts = false
    $excel.Save
    $excel.Quit()
  }
  t1.join
end

################################################################################################################
################################################################################################################

def screenshot_desktop
  sleep 1
  File.delete('Img_Temp.gif') if File.exists?('Img_Temp.gif')
  Win32::Screenshot::Take.of(:foreground).write('Img_Temp.gif')
  openImg = File.open("Img_Temp.gif", "rb")
  $imgBase64 = Base64.encode64(openImg.read)
  openImg.close
  File.delete('Img_Temp.gif')
  $imgBase64
end

def click_uia_button(obj, desc)
  cont_temp = 0
  while obj.nil? and cont_temp < 10
    sleep 0.5
    cont_temp += 1
  end
  raise "Botão <#{desc}> não foi encontrado." if obj.nil?
  obj.click
end
