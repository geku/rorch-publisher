# url = "https://api.meetup.com/2/events"
#     params = {params: { key: MeetupClient::API_KEY,
#                         sign: 'true',
#                         group_urlname: 'rubyonrails-ch',
#                         page: 1,
#                         status: 'upcoming'}}
#     response = RestClient.get(url, params)
#     expect(response.code).to eq(200)
#     events = JSON.parse(response)
#     events["results"].each do |evt|
#       time = Time.at(evt["time"]/1000)
#       puts "#{time} #{evt["description"]}\n#{evt["event_url"]}"
#     end