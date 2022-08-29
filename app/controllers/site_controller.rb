class SiteController < ApplicationController
  def newsletter
end
def search
@search=Article.search1(params[:s])
@posts=@search.search(params[:s],params[:page])
@res=Article.summaryres(params[:s])
@page={nb: @search.length, current: (params[:page].to_i == 0 ? 0 : params[:page].to_i)}
end
end
