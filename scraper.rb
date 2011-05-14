require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'bundler'

Bundler.require

require File.dirname(__FILE__) + '/app'

doc = Nokogiri::HTML(open('http://www.archive.org/browse.php?collection=etree&field=%2Fmetadata%2Fcreator'))
bands_lis = doc.search('table#browse li')
bands_lis.each do |li|
  links = li.search('a')
  band = links.first.text.downcase

  artist = Artist.first(:name => band) || Artist.new(:name => band)

  artist.update(
    details_link: links.first['href'],
    shows_link: links.last['href'],
    show_count: links.last.text.gsub(/\,/, '').to_i
  )
end

puts "DONE!"
exit
