require 'rubygems'
require 'nokogiri'
require 'open-uri'

@names = []
@urls = []
@emails = []
@hashfinal = {}

def get_all_the_names_of_val_doise_townhalls()
  webpage = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))
  webpage.xpath('//p/a[@class = "lientxt"]').each do |bli|
    @names << bli.text
  end
end


def get_all_the_urls_of_val_doise_townhalls()
  page = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))
  page.xpath('//p/a[@class = "lientxt"]/@href').each do |bam|
    @urls << bam.text
  end
end

def setup_urls()
  @urls.each do |i|
    i.slice!(0)
    i.insert(0, 'http://annuaire-des-mairies.com')
  end
end

def get_the_emails_of_townhalls_from_their_webpages()
  @urls.each do |k|
    noko = Nokogiri::HTML(open(k))
    noko.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |u|
      @emails << u.text
    end
  end
end

def filling_hash()
  s = 0
  while s < @names.length
    @hashfinal[@names[s]] = @emails[s]
    s = s + 1
  end
  puts @hashfinal
end

get_all_the_names_of_val_doise_townhalls()
get_all_the_urls_of_val_doise_townhalls()
setup_urls()
get_the_emails_of_townhalls_from_their_webpages()
filling_hash()
