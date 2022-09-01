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
@donation=Donation.new(donation_params)
if !@donation.save
render :donatie
else
render :donate_ok, layout: false
end
when "recordmanager:form:P7//1487"
#donation nl
@donation=Donation.new(donation_params)
if !@donation.save
render :donatie
else
render :donate_ok, layout: false
end
when "recordmanager:form:P9//1492"
#friend nl
@friendship=Friendship.new(friend_params)
if !@friendship.save
render :vriend
else
render :friend_ok, layout: false
end
when "recordmanager:form:P9//1493"
#friend en
@friendship=Friendship.new(friend_params)
if !@friendship.save
render :vriend
else
render :friend_ok, layout: false
end
when "recordmanager:form:P5//1499"
#newsletter english
@newsletter=Newsletter.new(newsletter_params)
if !@newsletter.save
render :nieuwsbrief
else
render :newsletter_ok, layout: false
end
when "recordmanager:form:P5//1501"
#newsletter nl
@newsletter=Newsletter.new(newsletter_params)
if !@newsletter.save
render :nieuwsbrief
else
render :newsletter_ok, layout: false
end
end

#render "site/thanks_donation"
end
def othershortroute
end
def paymentfailed
end
def payment
redirect_to payment_failed_en_path(locale: @currentlocale.to_s)
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
@newsletter=Newsletter.new
 render layout: false   
   end
  def index
@posts=Joinus.all
  end
def friend_params
params.permit(:typefriendship,:authorize,:amount,:iban,:firstname,:middlename,:lastname,:street,:housenumber,:postcode,:place,:land,:email,:telephone,:newsletter)
end
def donation_params
params.permit(:amount,:namely,:firstname,:email,:middlename,:lastname,:brochures,:street,:housenumber,:postcode,:place,:privacy,:telephone)
end
def newsletter_params
params.permit(:firstname, :prefix, :lastname, :email, :newsletter, :brochures, :street, :housenumber, :postcode, :city, :country, :phone, :privacy)
end
end
