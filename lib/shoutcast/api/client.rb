module Shoutcast
  module Api
    class Client
      require 'rest-client'
      require 'nori'

      def initialize(key:)
        @key = key
      end

      def top_500
        response = RestClient.get url('/legacy/Top500')
        Nori.new.parse(response)['stationlist']['station'].map do |attributes|
          Shoutcast::Api::Station.parse(attributes)
        end
      end

      private

      attr_accessor :key

      def base_url
        'http://api.shoutcast.com'
      end

      def url(path)
        "#{base_url}#{path}?k=#{key}"
      end
    end
  end
end
