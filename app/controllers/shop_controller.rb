class ShopController < ApplicationController
protect_from_forgery except: [:buybutton]
   def index
render "shop/index_#{I18n.locale}"
  end
   def graphql
render "shop/graphql_#{I18n.locale}"
  end
def buybutton
render layout: false, formats: [:js]
end
  def show
@shops=Shop.findbyurl(params[:title])
  end
end
