Rails.application.routes.draw do
post "/engine", to: "joinus#engine"
get "/engine", to: "joinus#engine"
get "buybutton", to: "shop#buybutton"
scope ':locale', locale: /en/ do

get "/", to: "site#search",
    constraints: lambda { |request| !["",nil].any?(request.params[:s]) }
get "page/:page/", to: "site#search",
    constraints: lambda { |request| !["",nil].any?(request.params[:s]) }, as: :searchpage
get "", to: "site#index"
  get 'friend', to: 'joinus#vriend'
  get 'donate', to: 'joinus#donatie'
  get 'join-us', to: 'joinus#index', as: :joinus_en
  get 'join-us/private', to: 'joinus/private#index'
  get 'join-us/private/:title', to: 'joinus/private#show'
  get 'join-us/commercial', to: 'joinus/professional#index'
  get 'join-us/commercial/:title', to: 'joinus/professional#show'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

get "watchandlisten", to: "listen#indexpage",
    constraints: lambda { |request| request.params[:page].to_i > 1}

get "watchandlisten/:title", to: "listen#show",
    constraints: lambda { |request| Postkl.find_by_url_en(request.params[:title]) }

get "/watchandlisten/type/:tag/",to: "listen#type"
get "watchandlisten", to: "listen#index"

get "concerts", to: "concerts#index"
get "concerts/:title", to: "concerts#show", as: :concert_en

get "shop", to: "shop#index"
get "education-talent/:title/:apply", to: "etpage#apply",
    constraints: lambda { |request| Apply.find_by_url_en(request.params[:title])}
get "education-talent/:title", to: "etpage#show"

get "education-talent", to: "etpage#index"
  get 'about-us/concertarchief', to: 'overons#concertarchief'
  get 'about-us/our-partners', to: 'overons#partners'

get ":title", to: "overons#musicians",
    constraints: lambda { |request| Aboutus.find_by_url_en(request.params[:title]).musicians.length > 0 rescue nil}
get "about-us/:title", to: "overons#show"
get "about-us", to: "overons#index"
get "musicians/:name", to: "overons#musician"

get "news", to: "news#indexpage",
    constraints: lambda { |request| request.params[:page].to_i > 1}

get ":title", to: "news#show",
    constraints: lambda { |request| News.find_by_url_en(request.params[:title]) }

get "news", to: "news#index"
get "contact", to: "site#contact"
post "graphql", to: "shop#graphql"
  get 'join-us/:title1/:title', to: 'joinus#otherroute'
  get 'join-us/:title1', to: 'joinus#othershortroute'
  get 'friend', to: 'joinus#vriend'
  get 'donate', to: 'joinus#donatie'
  get 'newsletter', to: 'joinus#nieuwsbrief'
    post "payment", to: "joinus#payment",as: :payment
    get "payment_failed", to: "joinus#paymentfailed", as: :payment_failed
end
scope '(:locale)', locale: /nl|/ do
get "", to: "site#search",
    constraints: lambda { |request| !["",nil].any?(request.params[:s]) }
get "/page/:page", to: "site#search",
    constraints: lambda { |request| !["",nil].any?(request.params[:s]) }, as: :searchpage_en
get "", to: "site#index"
  get 'vriend', to: 'joinus#vriend'
  get 'donatie', to: 'joinus#donatie'
  get 'nieuwsbrief', to: 'joinus#nieuwsbrief'
  get 'doe-mee', to: 'joinus#index', as: :joinus_nl
  get 'doe-mee/particulier', to: 'joinus/private#index'
  get 'doe-mee/particulier/:title', to: 'joinus/private#show'
  get 'doe-mee/zakelijk', to: 'joinus/professional#index'
  get 'doe-mee/zakelijk/:title', to: 'joinus/professional#show'
  get 'over-ons/concertarchief', to: 'overons#concertarchief'
  get 'over-ons/partners', to: 'overons#partners'
  get 'over-ons/perskit', to: "overons#perskit"
  get 'over-ons/:title', to: "overons#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

get "kijkenluister", to: "listen#indexpage",
    constraints: lambda { |request| request.params[:page].to_i > 1}


get "kijkenluister", to: "listen#index"

get "kijkenluister/:title", to: "listen#show",
    constraints: lambda { |request| Postkl.find_by_url_nl(request.params[:title]) }

get "concerten", to: "concerts#index"
get "concerten/:title", to: "concerts#show", as: :concert,locale: :nl
get "winkel", to: "shop#index"
get "educatie-talent/:title/:apply", to: "etpage#apply",
    constraints: lambda { |request| Apply.find_by_url_nl(request.params[:title])}
get "educatie-talent/:title", to: "etpage#show"
get "educatie-talent", to: "etpage#index"
get ":title", to: "overons#musicians",
    constraints: lambda { |request| Aboutus.find_by_url_nl(request.params[:title]).musicians.length > 0 rescue nil}
get "over-ons/:title", to: "overons#show"
get "over-ons", to: "overons#index"
get "musici/:name", to: "overons#musician"
get "nieuws", to: "news#indexpage",
    constraints: lambda { |request| request.params[:page].to_i > 1}

get ":title", to: "news#show",
    constraints: lambda { |request| News.find_by_url_nl(request.params[:title]) }

get "nieuws", to: "news#index"
get "contact", to: "site#contact"
post "graphql", to: "shop#graphql"

  get 'doe-mee/:title1/:title', to: 'joinus#otherroute'
  get 'doe-mee/:title1', to: 'joinus#othershortroute'
    post "payment", to: "joinus#payment",as: :payment_en
    get "payment_failed", to: "joinus#paymentfailed", as: :payment_failed_en

end

root to: "site#index"
end
