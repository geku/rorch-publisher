require 'dotenv'
require_relative 'event'
require_relative 'publisher/techup'

# Load config
Dotenv.load
Publisher::Techup.auth_key = ENV['TECHUP_AUTH_KEY']


# Demo code to publish event
desc = 'Wir führen "Lightning Talks" durch: Kurze, spontane Vorträge (5 bis maximal 20 Minuten) über ein Projekt, ein gem, eine Technologie, eine Erfahrung. Alle Teilnehmenden sind frei, etwas vorzustellen.

Wenn uns die Themen ausgehen oder 90 Minuten um sind, gehen wir in eine naheliegende Bar und diskutieren noch etwas weiter.'


event = Event.new(
  title: 'Railshöck Lightning Talks',
  description: desc,
  tags: ['ruby', 'rails', 'web'],
  location: 'Simplificator GmbH, Pfingstweidstrasse 6, 8005 Zürich',
  url: 'http://www.meetup.com/rubyonrails-ch/events/190749152/',
  time: DateTime.new(2014, 8, 20, 18,30)
)

techup = Publisher::Techup.new
url = techup.publish(event)

puts ''
puts "Event '#{event.title}' posted to Techup as:"
puts url
puts ''
