require "./lib/labeled_form_builder"
class JoinusController < ApplicationController
protect_from_forgery except: [:engine]
layout false, only: :engine
 def engine
elements=[]

#render json: {elements: elements, modified: true}
case params[:service]
when "recordmanager:form:P7//1485"
#donation en
when "recordmanager:form:P7//1487"
#donation nl
when "recordmanager:form:P9//1492"
#friend nl
@friendship=Friendship.new(friend_params)
if !@friendship.save
render :vriend
end
when "recordmanager:form:P9//1493"
#friend en
@friendship=Friendship.new(friend_params)
if !@friendship.save
render :vriend
end
when "recordmanager:form:P5//1499"
#newsletter english
when "recordmanager:form:P5//1501"
#newsletter nl

end

#render "site/thanks_donation"
end
def othershortroute
end
def otherroute
end
    def donatie
@donation=Donation.new
#render file: "#{Rails.root}/public/application.html_files/donatie_#{I18n.locale}.html", layout: false
render layout: false   
 end
    def vriend
@friendship=Friendship.new
#render file: "#{Rails.root}/public/application.html_files/vriend_#{I18n.locale}.html", layout: false
 render layout: false   
   end
 def nieuwsbrief
#render file: "#{Rails.root}/public/application.html_files/saved_resource_#{I18n.locale}.html", layout: false
 render layout: false   
   end
  def index
@posts=Joinus.all
  end
def friend_params
params.permit()
end
end
