# frozen_string_literal: true

require 'net/http'
require 'uri'

class HanRiver < TestBot::Message
  def run
    uri = URI.parse('http://hangang.dkserver.wo.tc')
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)
    puts "현재 한강물의 온도는 #{json['temp']}℃ 네요~"
  end
end
