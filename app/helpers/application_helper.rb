module ApplicationHelper
  def absolute_css_class_names
    %W[#{controller_name}_controller #{action_name}_action]
  end
end
