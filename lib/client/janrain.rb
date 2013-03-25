require 'httparty'
require 'json'

module Janrain
  def initialize(client_id, client_secret)
    if !client_id || !client_secret
      throw ArgError "You must input a client_id and a client_secret to initialize this module"
    end

    if ENV['JANRAIN_CLIENT_ID']
      @client_id = ENV['JANRAIN_CLIENT_ID']
      puts "The client_id has been set from an environment variable"
    else
      @client_id = client_id
    end 
    
    if ENV['JANRAIN_CLIENT_SECRET']
      @client_secret = ENV['JANRAIN_CLIENT_SECRET']
      puts "The client_secret has been set from an environment variable"
    else
      @client_secret = client_secret
    end
  end

  module CaptureClient
    def initialize(domain)  
      @janrainDomain = HTTP::URL.new("https://" + domain + ".rpxnow.com")
    end

    def captureQuery(endpoint, params)
      payload = Hash.new
      payload = params.each do |k, v|
        payload.push({ :k => v })
      end
      new_url = janrainDomain + endpoint
      r = HTTParty.post(new_url, payload)
      r.json
    end

    def add_client(description, features)
      captureQuery("/")
    end
  end

  module EngageClient
    def engageQuery
    end
  end

  module FederateClient
    def federateQuery
    end
  end
end
