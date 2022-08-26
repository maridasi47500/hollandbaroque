class NewsController < ApplicationController
   def index
@allposts=News.mynews
@news=@allposts.bypage(params[:page])

@moreposts=@allposts.moreposts(params[:page])

@datafound=@allposts.length
  end
   def indexpage
@allposts=News.mynews
@news=@allposts.bypage(params[:page])

@moreposts=@allposts.moreposts(params[:page])

@datafound=@allposts.length
render layout: false
  end
  def show
@post=News.findbyurl(params[:title])
@contents=@post.mycontents
@othertitle=params[:locale] == "en" ? @post.url_nl : @post.url_en

  end
end
