module Shoutcast
  module Api
    class Client
      require 'rest-client'
      require 'nori'

      def initialize(key:)
        @key = key
      end

      def top_500
        response = RestClient.get(
          url(path: '/legacy/Top500')
        )
        parse_stations(response)
      end

      def search(
        keyword:,
        limit:      nil,
        offset:     nil,
        bitrate:    nil,
        media_type: nil
      )
        response = RestClient.get(
          url(
            path: '/legacy/stationsearch',
            parameters: {
              search: keyword,
              limit:  build_limit_parameter(limit: limit, offset: offset),
              br:     bitrate,
              mt:     media_type
            }
          )
        )
        parse_stations(response)
      end

      def genre_search(
        genre:,
        limit:      nil,
        offset:     nil,
        bitrate:    nil,
        media_type: nil
      )
        response = RestClient.get(
          url(
            path: '/legacy/genresearch',
            parameters: {
              genre: genre,
              limit: build_limit_parameter(limit: limit, offset: offset),
              br:    bitrate,
              mt:    media_type
            }
          )
        )
        parse_stations(response)
      end

      private

      attr_accessor :key

      def url(path:, parameters: {})
        Shoutcast::Api::Url.new(
          path:       path,
          key:        key,
          parameters: parameters
        ).to_s
      end

      def parse_stations(response)
        return [] if response.nil?
        parsed_response = Nori.new.parse(response)
        return [] if parsed_response['stationlist'].nil?
        return [] if parsed_response['stationlist']['station'].nil?
        Nori.new.parse(response)['stationlist']['station'].map do |attributes|
          Shoutcast::Api::Station.parse(attributes)
        end
      end

      def build_limit_parameter(limit: nil, offset: nil)
        return nil if limit.nil?
        parameter = limit.to_s
        parameter += ",#{offset}" unless offset.nil?
        parameter
      end
    end
  end
end
