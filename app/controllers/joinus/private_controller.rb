class Joinus::PrivateController < ApplicationController
def index

@posts=Private.all

end
def show
@post=Private.findbyurl(params[:title])
@othertitle=params[:locale] == "en" ? @post.url_nl : @post.url_en

end

end
