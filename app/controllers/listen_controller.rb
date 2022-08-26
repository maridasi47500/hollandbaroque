class ListenController < ApplicationController
   def index
@featured=Postkl.featured

@allposts=Postkl.allposts
@firsthalf=@allposts.firsthalf(params[:page])
@secondhalf=@allposts.secondhalf(params[:page])
@moreposts=@allposts.moreposts(params[:page])
  end
    def indexpage
@allposts=Postkl.allposts
@posts=@allposts.posts(params[:page])
@moreposts=@allposts.moreposts(params[:page])

@datafound=@allposts.length
    end
  def show
@post=Postkl.findbyurl(params[:title])
@contents=@post.mycontents
@othertitle=params[:locale] == "en" ? @post.url_nl : @post.url_en

  end
end
