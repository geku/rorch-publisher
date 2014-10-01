require 'jsoneur'
require 'sanitize'
require_relative 'event'

Jsoneur.add('meetup_event', 'https://api.meetup.com') do |service|
  service.path = '/2/event/%{event_id}'
  service.default_params = {'sign' => true, 'photo-host' => 'public', 'page' => 20}
  service.empty_response = {}
end

class Meetup

  def event(id)
    event = Jsoneur['meetup_event'].get(event_id: id, key: self.class.api_key)
    venue = event.venue
    description = Sanitize.fragment(event.description)

    Event.new(
      title: event.name,
      description: description,
      tags: ['ruby', 'rails', 'web'],
      location: "#{venue.name}, #{venue.address_1}, #{venue.city}",
      url: event.event_url,
      time:  Time.at(event.time / 1000).to_datetime
    )
  end

  class << self
    attr_accessor :api_key
  end

end