require 'rubygems'
require 'nokogiri'
require 'open-uri'

@prices = []
@cryptonames = []
@hash = {}

def get_crytocurrencies_names()
  webpage = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
  webpage.xpath('//td/a[@class = "currency-name-container link-secondary"]').each do |bli|
    @cryptonames << bli.text
  end
end

def get_crytocurrencies_prices()
  page = Nokogiri::HTML(open('https://coinmarketcap.com/all/views/all/'))
  page.xpath('//td/a[@class = "price"]').each do |bam|
    @prices << bam.text
  end
end

def hashfilling()
  s = 0
  while s < @cryptonames.length
    @hash[@cryptonames[s]] = @prices[s]
    s = s + 1
  end
  puts @hash
end

get_crytocurrencies_names()
get_crytocurrencies_prices()
hashfilling()
