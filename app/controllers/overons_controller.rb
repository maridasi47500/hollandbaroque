class OveronsController < ApplicationController
layout "musicians", only: :musicians 
layout false, only: :musician 
  def partners
render template: "overons/partners_#{I18n.locale}.html.erb"
  end

  def perskit
render template: "overons/perskit_#{I18n.locale}.html.erb"
  end
   def index
@posts=Aboutus.all.where.not("title_#{I18n.locale}",["",nil])
  end
def musicians
@post=Aboutus.findbyurl(params[:title])
@musicians=@post.musicians
@othertitle=params[:locale] == "en" ? @post.url_nl : @post.url_en

render layout: "musicians"
  end
def musician
@musician=Musician.find_by_link(params[:name])
render layout: false
end
  def show
@post=Aboutus.findbyurl(params[:title])
@othertitle=params[:locale] == "en" ? @post.url_nl : @post.url_en
@contents=@post.mycontents

  end
def concertarchief
@concerts=Concert.archive.allmyconcerts

end
end
