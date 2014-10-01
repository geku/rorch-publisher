require 'json'
require 'hashie'
require 'spec_helper'
require_relative './../../meetup'

describe Meetup do
  describe '#event' do
    let(:event) { Meetup.new.event(12345) }
    let(:meetup_json) { JSON.parse(File.read("./spec/support/meetup.json")) }
    let(:meetup_data) { Hashie::Mash.new(meetup_json) }
    let(:event_time) { DateTime.new(2014, 10, 15, 18, 30, 0, "+2") }

    before do
      allow_any_instance_of(Meetup).to receive(
        :meetup_event
      ).and_return(
        meetup_data
      )
    end

    it 'has correct attributes' do
      expect(event).to have_attributes(
        time: event_time,
        title: 'Railshöck Lightning Talks',
        description: a_string_including('Lightning Talks'),
        location: 'local.ch, Konradstrasse 12, Zürich',
        url: 'http://www.meetup.com/rubyonrails-ch/events/206130982/',
        tags: %w{ruby rails web}
      )
    end
  end
end
