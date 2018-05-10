Before do |feature|
  $hash_massa_dados = Hash.new
  $status_exec_sheet = 0
end

After do |feature|

end

Before do |scenario|
  system("start calc.exe")
  sleep 2
end

AfterStep do |step|
  if !$imgBase64.nil?
    embed("data:image/gif;base64,#{$imgBase64}",'image/gif')
    $imgBase64.clear
  end
  $imgBase64 = nil
end


After do |scenario|
  if scenario.failed?
    $imgBase64 = nil
    screenshot_desktop
    embed("data:image/gif;base64,#{$imgBase64}",'image/gif')
  end
  $imgBase64 = nil
  system('taskkill /f /im calc.exe')
end

