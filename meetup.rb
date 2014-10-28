require 'jsoneur'
require 'sanitize'
require_relative 'event'

class Meetup
  def initialize
    Jsoneur.add('meetup_event', 'https://api.meetup.com') do |service|
      service.path = '/2/event/%{event_id}'
      service.default_params = {'sign' => true, 'photo-host' => 'public', 'page' => 20}
      service.empty_response = {}
    end
  end

  def event(id)
    mevent = meetup_event(id)
    venue = mevent.venue
    description = Sanitize.fragment(mevent.description).strip

    Event.new(
      title: mevent.name,
      description: description,
      tags: ['ruby', 'rails', 'web'],
      location: "#{venue.name}, #{venue.address_1}, #{venue.city}",
      url: mevent.event_url,
      time: Time.at(mevent.time / 1000).to_datetime
    )
  end

  def meetup_event(id)
    @data ||= Jsoneur['meetup_event'].get(event_id: id, key: self.class.api_key)
  end

  class << self
    attr_accessor :api_key
  end
end