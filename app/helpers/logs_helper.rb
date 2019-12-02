# frozen_string_literal: true

module LogsHelper
  def chart_color(log)
    color = log.color
    case color
    when "red"
      "#F44336"
    when "blue"
      "#3F51B5"
    when "green"
      "#4CAF50"
    when "orange"
      "#FF9800"
    when "purple"
      "#673AB7"
    when "pink"
      "#E91E63"
    when "brown"
      "#795548"
    end
  end

  def log_submit_label(from)
    if from == :new
      "作成"
    else
      "更新"
    end
  end
end
