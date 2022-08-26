class ApplicationController < ActionController::Base


around_action :switch_locale
before_action :findpage
def findpage
begin
@page=Pagesite.findbyurl(request.path)
rescue => e
p e.inspect
end

end
def switch_locale(&action)
  locale = params[:locale] || I18n.default_locale
  @currentlocale=locale.to_s == "en" ? "en" : nil
  @opposite=locale.to_s == "nl" ? "en" : nil
  
I18n.with_locale(locale, &action)

end
end
