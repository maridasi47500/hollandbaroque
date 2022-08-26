class News < Article
def self.mynews
where.not("title_#{I18n.locale.to_s}" => ["",nil]).limit(8)
end
def self.bypage(page)
p=page.to_i == 0 ? 0 : ((page.to_i - 1) * 8)
limit(8).offset(p)
end
def self.moreposts(page)
p=page.to_i == 0 ? 0 : ((page.to_i - 1) * 8 )
p+=8
limit(5).offset(p)
end
end
