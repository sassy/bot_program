#!/usr/bin/ruby
require 'rubygems'
require 'twitter'
require 'twitter/console'
require 'oauth'

consumer = OAuth::Consumer.new(
  "consumer key",
  "consumer secret",
  :site => "http://twitter.com"
)
token = consumer.get_request_token
puts token.authorize_url
pin = gets.chop
puts pin
access_token = token.get_access_token(:oauth_verifier => pin)
puts access_token.token
puts access_token.secret



