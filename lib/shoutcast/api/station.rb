module Shoutcast
  module Api
    class Station
      attr_accessor :id, :name, :mt, :br, :genres, :ct, :lc, :logo
      alias media_type mt
      alias bitrate br
      alias current_track ct

      class << self
        def parse(attributes)
          station        = new
          station.id     = attributes['@id']
          station.name   = attributes['@name']
          station.mt     = attributes['@mt']
          station.br     = attributes['@br']
          station.genres = parse_genres(attributes)
          station.ct     = attributes['@ct']
          station.lc     = attributes['@lc']
          station.logo   = attributes['@logo']
          station
        end

        private

        def parse_genres(attributes)
          genres = []
          current_genre = attributes['@genre']
          genre_index = 1
          until current_genre.nil?
            genres << current_genre
            genre_index += 1
            current_genre = attributes["@genre#{genre_index}"]
          end
          genres
        end
      end
    end
  end
end
