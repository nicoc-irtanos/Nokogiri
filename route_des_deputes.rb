require 'rubygems'
require 'nokogiri'
require 'open-uri'

@names = []
@first_names = []
@last_names = []
@urls = []
@emails = []

@arraydehashs = []

def get_mps_names
  webpage = Nokogiri::HTML(open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
  webpage.xpath('//ul[@class = "col3"]/li/a').each do |bli|
    @names << bli.text
  end
end

def orga
  @names.map{|i| i.delete_prefix!("M. ")}
  @names.map{|i| i.delete_prefix!("Mme ")}
  @names.each{|i| array = i.split(" ")
  @first_names<<  array[0]
  @last_names<< array.drop(1).join(" ")
  }
end

def get_urls
  page = Nokogiri::HTML(open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
  page.xpath('//ul[@class = "col3"]/li/a/@href').each do |bam|
    @urls << bam.text
  end
end

def format_urls
  @urls.each do |i|
  i.insert(0, 'http://www2.assemblee-nationale.fr')
  end
end

def get_mps_emails
  @urls.each do |k|
    noko = Nokogiri::HTML(open(k))
    noko.xpath('/html/body/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[1]/a/@href').each do |u|
      puts u.text
      @emails << u.text
    end
  end
end

puts @emails

get_mps_names
orga
get_urls
format_urls
get_mps_emails
