#encoding: utf-8

require 'magic_encoding'

class CalcLocators

  def btn_calc(name)
    return $win.find(control_type: :button, name: name)
  end

  def frame_result
    return $win.find(control_type: :text, id: "150")
  end

end