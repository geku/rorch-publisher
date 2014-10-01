class Event

  attr_accessor :title,
                :location,
                :geo_location,
                :url,
                :tags,
                :description,
                :time           # as DateTime.new(2014,8,6, 18,30)

  def initialize(options = {})
    self.title       = options[:title]
    self.description = options[:description]
    self.location    = options[:location]
    self.time        = options[:time]
    self.url         = options[:url]
    self.tags        = options[:tags]

    assign_geo_location
  end

  def tags_text
    tags.join(', ')
  end

  def to_s
    "
  Title:    #{title}
  Location: #{location}
  Time:     #{time}
  URL:      #{url}
  Tags:     #{tags.join(', ')}
  Location: #{location}

  #{description}
  "
  end

  private

    def assign_geo_location
      self.geo_location = case location
      when /local\.ch/
        '{"address_components":[{"long_name":"12","short_name":"12","types":["street_number"]},{"long_name":"Konradstrasse","short_name":"Konradstrasse","types":["route"]},{"long_name":"Gewerbeschule","short_name":"Gewerbeschule","types":["sublocality_level_2","sublocality","political"]},{"long_name":"District 5","short_name":"District 5","types":["sublocality_level_1","sublocality","political"]},{"long_name":"Zurich","short_name":"Zurich","types":["locality","political"]},{"long_name":"Zürich District","short_name":"Zürich District","types":["administrative_area_level_2","political"]},{"long_name":"Zurich","short_name":"ZH","types":["administrative_area_level_1","political"]},{"long_name":"Switzerland","short_name":"CH","types":["country","political"]},{"long_name":"8005","short_name":"8005","types":["postal_code"]}],"formatted_address":"Konradstrasse 12, 8005 Zurich, Switzerland","geometry":{"location":{"lat":47.3802331,"lng":8.536817400000018},"location_type":"ROOFTOP","viewport":{"ta":{"d":47.3788841197085,"b":47.3815820802915},"ga":{"b":8.535468419708536,"d":8.5381663802915}}},"types":["street_address"]}'
      when /Simplificator/
        '{"address_components":[{"long_name":"6","short_name":"6","types":["street_number"]},{"long_name":"Industriequartier Hard","short_name":"Industriequartier Hard","types":["establishment"]},{"long_name":"Pfingstweidstrasse","short_name":"Pfingstweidstrasse","types":["route"]},{"long_name":"Escher Wyss","short_name":"Escher Wyss","types":["sublocality_level_2","sublocality","political"]},{"long_name":"District 5","short_name":"District 5","types":["sublocality_level_1","sublocality","political"]},{"long_name":"Zurich","short_name":"Zurich","types":["locality","political"]},{"long_name":"Zürich District","short_name":"Zürich District","types":["administrative_area_level_2","political"]},{"long_name":"Zurich","short_name":"ZH","types":["administrative_area_level_1","political"]},{"long_name":"Switzerland","short_name":"CH","types":["country","political"]},{"long_name":"8005","short_name":"8005","types":["postal_code"]}],"formatted_address":"Pfingstweidstrasse 6, Industriequartier Hard, 8005 Zurich, Switzerland","geometry":{"location":{"lat":47.3878883,"lng":8.51864390000003},"location_type":"ROOFTOP","viewport":{"ta":{"d":47.3865393197085,"b":47.3892372802915},"ga":{"b":8.517294919708547,"d":8.519992880291511}}},"partial_match":true,"types":["street_address"]}'
      when /Colab/
        '{"address_components":[{"long_name":"37","short_name":"37","types":["street_number"]},{"long_name":"Zentralstrasse","short_name":"Zentralstrasse","types":["route"]},{"long_name":"Sihlfeld","short_name":"Sihlfeld","types":["sublocality_level_2","sublocality","political"]},{"long_name":"Wiedikon","short_name":"Wiedikon","types":["sublocality_level_1","sublocality","political"]},{"long_name":"Zurich","short_name":"Zurich","types":["locality","political"]},{"long_name":"Zürich District","short_name":"Zürich District","types":["administrative_area_level_2","political"]},{"long_name":"Zurich","short_name":"ZH","types":["administrative_area_level_1","political"]},{"long_name":"Switzerland","short_name":"CH","types":["country","political"]},{"long_name":"8003","short_name":"8003","types":["postal_code"]}],"formatted_address":"Zentralstrasse 37, 8003 Zurich, Switzerland","geometry":{"location":{"lat":47.3715092,"lng":8.519503699999973},"location_type":"ROOFTOP","viewport":{"ta":{"d":47.3701602197085,"b":47.3728581802915},"ga":{"b":8.518154719708491,"d":8.520852680291455}}},"types":["street_address"]}'
      else
        ''
      end
    end

end
