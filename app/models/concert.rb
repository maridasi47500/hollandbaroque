class Concert < Article
has_many :playtimes
has_many :object_table_concerts
#has_many :listlocations, class_name:"Location", through: :playtimes, source: :location
def self.allconcerts
all
end
def mycontents
[products,object_table_concerts,playdateswrappers, contents,mediatexts,youtubes,swipers,galleries,tickers,musicians,wpcolumns,images,files].sum.sort_by{|x|x.orderid}
end

def previousconcert
Concert.where('id < ?', self.id).order(id: :desc).limit(1)[0]
end
def nextconcert
Concert.where('id > ?', self.id).order(id: :asc).limit(1)[0]
end
def currentpage
Concert.where('id <= ?', self.id).select('cast((count(*)/10 + 1) as int) as number')[0].try(:number).to_i
end
def self.oldconcerts
cond='old > 0'
allconcerts_page.having(cond)
end
def self.nextconcerts
cond='new > 0'
allconcerts_page.having(cond)
end
def is_old?
Concert.where(id: self.id).allconcerts_page.oldconcerts.length > 0
end
def is_next?
Concert.where(id: self.id).allconcerts_page.nextconcerts.length > 0
end
def self.allconcerts_page

joins(:playtimes).select("articles.*, count(date(playtimes.date) between '0001-01-01' and '#{Date.today - 1.day}') as old, count(date(playtimes.date) between '#{Date.today}' and '2100-01-01') as new").group('articles.id')
end
def self.archive
all
end
def self.allmyconcerts
joins(:playtimes).left_joins(:youtubes).joins("left join locations on locations.id = playtimes.location_id").select("articles.*, json_group_array(distinct locations.place) as listlocations, json_group_array(strftime('%m',date(playtimes.date))) as listmonths,count(distinct playtimes.location_id) as nblocations,count(lower(youtubes.title_en) like '%livestream%' or lower(youtubes.title_nl) like '%livestream%') as nblivestreams").group('articles.id')

end
def nbplaytimes
self.playtimes.joins(:location).select('count(distinct locations.place) as mycount')[0].mycount || 0
rescue => e
0
end
def nblivestreams
self.youtubes.select('count(lower(title_en) like "%livestream%" or lower(title_nl) like "%livestream%") as mycount')[0].mycount
end
def self.group_by_month_and_array_dates
joins(:playtimes).joins("left join locations on locations.id = playtimes.location_id").all.select("articles.*, json_group_array(distinct playtimes.location_id) as locations,date(playtimes.date),strftime('%m',date(playtimes.date)) as mymonth").group('strftime("%m",date(playtimes.date))')
end

def self.group_by_place_and_array_months
joins(:playtimes).joins("left join locations on locations.id = playtimes.location_id").all.select("playtimes.id as playtimeid, locations.id as locationid, locations.city,locations.place,  playtimes.location_id,json_group_array(strftime('%m',date(playtimes.date))) as months").group('locations.id').having('city is not null and place is not null')
end
end
