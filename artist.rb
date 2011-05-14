class Artist
  include DataMapper::Resource

  property :id,           Serial
  property :name,         String
  property :shows_link,   String
  property :show_count,   String
  property :details_link, String

  def self.to_json
    all.map(&:json_attributes).to_json
  end

  def json_attributes
    {details_link: details_link, name: name, show_count: show_count, shows_link: shows_link}
  end

  def to_json
    json_attributes.to_json
  end
end

DataMapper.auto_upgrade!
