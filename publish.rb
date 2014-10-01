require 'dotenv'
require_relative 'event'
require_relative 'meetup'
require_relative 'publisher/techup'

require 'awesome_print'

class Publish

  def initialize
    load_config

    @meetup = Meetup.new
    @techup = Publisher::Techup.new
  end

  def load_config
    Dotenv.load
    Publisher::Techup.auth_key = ENV['TECHUP_AUTH_KEY']
    Meetup.api_key             = ENV['MEETUP_API_KEY']
  end

  def for(meetup_id, publish = false)
    event = @meetup.event(meetup_id)
    if publish
      url = @techup.publish(event)
    else
      event
    end
  end
end
