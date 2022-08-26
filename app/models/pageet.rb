class Pageet < Article 
def self.allpages
where.not("title_#{I18n.locale.to_s}" => ["",nil]).limit(8)
end

end
