class ConcertsController < ApplicationController
  def index
@concerts=Concert.allconcerts.allmyconcerts
@myarray=Concert.allconcerts.group_by_month_and_array_dates
@array2=Concert.allconcerts.group_by_place_and_array_months
  end

  def show
@concert=Concert.findbyurl(params[:title])
@othertitle=params[:locale] == "en" ? @concert.url_nl : @concert.url_en
@contents=@concert.mycontents

if @concert.is_old?
render :oldconcert
else
render :show
end
  end
end
