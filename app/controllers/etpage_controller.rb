class EtpageController < ApplicationController
   def index
@posts=Pageet.allpages

  end

  def show
@post=Pageet.findbyurl(params[:title])
@contents=@post.mycontents
@othertitle=params[:locale] == "en" ? @post.url_nl : @post.url_en

  end
  def apply
@mypost=Pageet.findbyurl(params[:title])
@post=Apply.findbyurl(params[:title])
@contents=@post.mycontents
@othertitle=params[:locale] == "en" ? @post.url_nl : @post.url_en

  end
end
