class Joinus::ProfessionalController < ApplicationController
def index
@posts=Commercial.all

end
def show
@post=Commercial.findbyurl(params[:title])
@othertitle=params[:locale] == "en" ? @post.url_nl : @post.url_en

end

end
