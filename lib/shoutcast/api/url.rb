module Shoutcast
  module Api
    class Url
      def initialize(path:, key:, parameters: {})
        @path = path
        @parameters = { k: key }
        @parameters.merge!(parameters) unless parameters.nil?
        @parameters.delete_if { |_, value| value.nil? }
      end

      def to_s
        URI::HTTP.build(
          host:  base_uri.host,
          path:  base_uri.path,
          query: parameters_query
        ).to_s
      end

      private

      attr_accessor :path, :parameters

      def scheme
        'http'
      end

      def host
        'api.shoutcast.com'
      end

      def base_uri
        @base_uri ||= URI.join("#{scheme}://#{host}", path)
      end

      def parameters_query
        return '' if parameters.empty?
        URI.encode_www_form(parameters)
      end
    end
  end
end
