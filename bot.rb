#!/usr/bin/ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'twitter'
require 'twitter/console'
require 'oauth'

def sayTweet(client) 
  h = Time.now.hour
  if h == 1 || h == 13
    str = "test1"
  elsif h == 2 || h == 14
    str = "test2"
  else
    str = "test message"
  end
  puts str
  client.status(:post, str)
end

def reply(client)
  timeline = client.timeline_for(:mentions) do |status|
    if Time.now - 60 * 60 < status.created_at
      str = "@" + status.user.screen_name
      str += " 返信メッセージ"
      puts status.text
      client.status(:post, str)
      return true;
    end
  end
  return false
end

Twitter::Client.configure do |conf|
  conf.oauth_consumer_token = "consumer key" 
  conf.oauth_consumer_secret = "consumer secret"
end

twitter_client = Twitter::Client.new(:oauth_access => {
  :key => "access key",
  :secret => "access secret"
})

ok = reply(twitter_client)
if !ok
  sayTweet(twitter_client)
end
#twitter_client.status(:post, Time.now.to_s)
