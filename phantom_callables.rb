# -*- encoding : utf-8 -*-
require 'open-uri'
require 'json'
require 'nokogiri'
require 'webrick/httputils'

RIOT_KEY = "RGAPI-889fcbc0-112c-4633-a953-8d7ee5f9a96e"

def to_escaped_uri(uri)
  uri_str = uri.to_s
  uri_str.force_encoding('binary')
  escaped_uri_str = WEBrick::HTTPUtils.escape(uri_str)
end

def summoner_id_by_username(username)
  escaped_uri = to_escaped_uri("https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/#{username}?api_key=#{RIOT_KEY}")
  doc = Nokogiri::HTML(open(escaped_uri).read)
  doc.encoding = 'utf-8'
  data = JSON.parse(doc.css('p').text)
  final = data[username.downcase]["id"]
end

def mastery_page_by_id(id)
  doc = Nokogiri::HTML(open("https://na.api.pvp.net/api/lol/na/v1.4/summoner/#{id}/masteries?api_key=#{RIOT_KEY}").read)
  doc.encoding = 'utf-8'
  data = JSON.parse(doc.css('p').text)
  final = data.first[1]["pages"].first["name"]
end
