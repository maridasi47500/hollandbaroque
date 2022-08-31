ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
p instance.error_message
p html_tag
  x=""
if !html_tag.include?("<label")
      if instance.error_message.is_a?(Array)

x << "<div class=\"offset-md-3 col-md-9 cx_grid-col\">"
	x << "<div class=\" invalid-feedback cx_field-error\">#{instance.error_message.uniq.join(', ')}</div>"
		x << "</div>"
else
x << "<div class=\"offset-md-3 col-md-9 cx_grid-col\">"
		x << "<div class=\" hidden invalid-feedback cx_field-error\">#{instance.error_message}</div>"
		x << "</div>"
end
end

    "#{html_tag}#{x}".gsub('form-control'," form-control-sm with_error ").html_safe
end