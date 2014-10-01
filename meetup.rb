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
    venue = meetup_event.venue
    description = Sanitize.fragment(meetup_event.description).strip

    Event.new(
      title: meetup_event.name,
      description: description,
      tags: ['ruby', 'rails', 'web'],
      location: "#{venue.name}, #{venue.address_1}, #{venue.city}",
      url: meetup_event.event_url,
      time: Time.at(meetup_event.time / 1000).to_datetime
    )
  end

  def meetup_event
    @data ||= Jsoneur['meetup_event'].get(event_id: id, key: self.class.api_key)
  end

  class << self
    attr_accessor :api_key
  end
end