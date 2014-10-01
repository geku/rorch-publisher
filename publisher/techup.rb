require 'date'
require 'mechanize'

module Publisher
  class Techup
    def publish(event)
      raise "No TECHUP AUTH KEY defined" unless self.class.auth_key

      agent = Mechanize.new do |agent|
        cookie = Mechanize::Cookie.new domain: '.techup.ch', name: 'techupauth2', value: self.class.auth_key, path: '/'
        agent.cookie_jar << cookie
      end

      page = agent.get('http://techup.ch/submit')
      form = page.forms.first

      form['event[name]'] = event.title
      form['event[description]'] = event.description
      form['event[tagsText]'] = event.tags_text
      form['event[link]'] = event.url

      form['event[location]'] = event.location
      form['event[geolocation]'] = event.geo_location

      form['is_free'] = 'yes'
      form['event[twitter]'] = 'railsCH'


      form['event[dateFrom][date][day]']    = event.time.day
      form['event[dateFrom][date][month]']  = event.time.month
      form['event[dateFrom][date][year]']   = event.time.year
      form['event[dateFrom][time][hour]']   = event.time.hour
      form['event[dateFrom][time][minute]'] = event.time.minute

      form['event[dateTo][date][day]']      = event.time.day
      form['event[dateTo][date][month]']    = event.time.month
      form['event[dateTo][date][year]']     = event.time.year
      form['event[dateTo][time][hour]']     = event.time.hour
      form['event[dateTo][time][minute]']   = event.time.minute

      response =  form.submit
      response.uri.to_s
    end

    class << self
      attr_accessor :auth_key
    end

  end
end