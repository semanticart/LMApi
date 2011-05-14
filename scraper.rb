require 'open-uri'
require 'nokogiri'
require 'json'

doc = Nokogiri::HTML(open('http://www.archive.org/browse.php?collection=etree&field=%2Fmetadata%2Fcreator'))
bands_lis = doc.search('table#browse li')
data = bands_lis.inject({}) do |hash, li|
  links = li.search('a')
  band = links.first.text
  hash[band] = {
    'details_link' => links.first['href'],
    'shows_link'   => links.last['href'],
    'show_count'   => links.last.text.gsub(/\,/, '').to_i
  }
  hash
end

File.open('data.json', 'w'){|f| f.print JSON.dump(data)}
