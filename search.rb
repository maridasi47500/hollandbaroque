require "nokogiri"
require "open-uri"
@doc=Nokogiri::HTML(URI.open("./testsearch.html"))
nbitem= @doc.css('.concert-card-search').length
p "#{nbitem} par page"
