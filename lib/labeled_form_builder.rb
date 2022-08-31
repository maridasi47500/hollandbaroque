class LabeledFormBuilder < ActionView::Helpers::FormBuilder
  def label(field_name, label = nil, options = {})
    if options.delete(:req)
      label ||= field_name.to_s.humanize
      label = label + " " + @template.content_tag(:span, "*", :class => "cx_required-mark") 
    end
    super(field_name, label, options)
  end
end