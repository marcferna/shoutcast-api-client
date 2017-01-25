require 'spec_helper'

describe Shoutcast::Api::Client do
  context '#initialize' do
    it 'requires the key attribute' do
      expect { Shoutcast::Api::Client.new }.to raise_error(ArgumentError)
    end

    it 'succeeds with a key attribute' do
      expect(Shoutcast::Api::Client.new(key: 'key')).to be
    end
  end

  context '.top_500' do
    let(:client) { Shoutcast::Api::Client.new(key: 'key') }
    before do
      expect(RestClient).to receive(:get) {
        File.read('spec/fixtures/top_500_response.xml')
      }
    end

    it 'parses all the stations' do
      expect(client.top_500.count).to eq(6)
    end

    it 'returns station instances' do
      expect(client.top_500.first).to be_a(Shoutcast::Api::Station)
    end
  end

  context '.search' do
    let(:client) { Shoutcast::Api::Client.new(key: 'key') }

    context 'parameters' do
      let(:search_parameters) {
        {
          keyword:    'radio marca',
          limit:      10,
          offset:     5,
          bitrate:    128,
          media_type: 'audio/mpeg'
        }
      }

      it 'includes parameters in the query' do
        expect(RestClient).to receive(:get).with(
          'http://api.shoutcast.com/legacy/stationsearch?'\
          'k=key&search=radio+marca&limit=10%2C5&br=128&mt=audio%2Fmpeg'
        )
        client.search(search_parameters)
      end

      context 'limit' do
        let(:search_parameters) {
          {
            keyword:    'radio marca',
            limit:      limit,
            offset:     offset
          }
        }
        context 'limit present' do
          let(:limit) { 10 }

          context 'offset nil' do
            let(:offset) { nil }

            it 'only includes limit' do
              expect(RestClient).to receive(:get).with(
                'http://api.shoutcast.com/legacy/stationsearch?'\
                'k=key&search=radio+marca&limit=10'
              )
              client.search(search_parameters)
            end
          end
        end

        context 'limit nil' do
          let(:limit) { nil }

          context 'offset nil' do
            let(:offset) { nil }

            it 'does not include limit nor offset' do
              expect(RestClient).to receive(:get).with(
                'http://api.shoutcast.com/legacy/stationsearch?'\
                'k=key&search=radio+marca'
              )
              client.search(search_parameters)
            end
          end

          context 'offset present' do
            let(:offset) { 4 }

            it 'does not include limit nor offset' do
              expect(RestClient).to receive(:get).with(
                'http://api.shoutcast.com/legacy/stationsearch?'\
                'k=key&search=radio+marca'
              )
              client.search(search_parameters)
            end
          end
        end
      end
    end

    context 'no results' do
      before do
        expect(RestClient).to receive(:get) {
          File.read('spec/fixtures/empty_response.xml')
        }
      end

      it 'returns empty array' do
        expect(client.search(keyword: 'radio marca')).to eq([])
      end
    end

    context 'results present' do
      before do
        expect(RestClient).to receive(:get) {
          File.read('spec/fixtures/search_response.xml')
        }
      end

      it 'parses all the stations' do
        expect(client.search(keyword: 'radio marca').count).to eq(4)
      end

      it 'returns station instances' do
        expect(client.search(keyword: 'radio marca').first).to be_a(
          Shoutcast::Api::Station
        )
      end
    end
  end

  context '.genre_search' do
    let(:client) { Shoutcast::Api::Client.new(key: 'key') }

    context 'parameters' do
      let(:search_parameters) {
        {
          genre:    'news',
          limit:      10,
          offset:     5,
          bitrate:    128,
          media_type: 'audio/mpeg'
        }
      }

      it 'includes parameters in the query' do
        expect(RestClient).to receive(:get).with(
          'http://api.shoutcast.com/legacy/genresearch?'\
          'k=key&genre=news&limit=10%2C5&br=128&mt=audio%2Fmpeg'
        )
        client.genre_search(search_parameters)
      end

      context 'limit' do
        let(:search_parameters) {
          {
            genre:  'news',
            limit:  limit,
            offset: offset
          }
        }
        context 'limit present' do
          let(:limit) { 10 }

          context 'offset nil' do
            let(:offset) { nil }

            it 'only includes limit' do
              expect(RestClient).to receive(:get).with(
                'http://api.shoutcast.com/legacy/genresearch?'\
                'k=key&genre=news&limit=10'
              )
              client.genre_search(search_parameters)
            end
          end
        end

        context 'limit nil' do
          let(:limit) { nil }

          context 'offset nil' do
            let(:offset) { nil }

            it 'does not include limit nor offset' do
              expect(RestClient).to receive(:get).with(
                'http://api.shoutcast.com/legacy/genresearch?'\
                'k=key&genre=news'
              )
              client.genre_search(search_parameters)
            end
          end

          context 'offset present' do
            let(:offset) { 4 }

            it 'does not include limit nor offset' do
              expect(RestClient).to receive(:get).with(
                'http://api.shoutcast.com/legacy/genresearch?'\
                'k=key&genre=news'
              )
              client.genre_search(search_parameters)
            end
          end
        end
      end
    end

    context 'no results' do
      before do
        expect(RestClient).to receive(:get) {
          File.read('spec/fixtures/empty_response.xml')
        }
      end

      it 'returns empty array' do
        expect(client.genre_search(genre: 'news')).to eq([])
      end
    end

    context 'results present' do
      before do
        expect(RestClient).to receive(:get) {
          File.read('spec/fixtures/search_response.xml')
        }
      end

      it 'parses all the stations' do
        expect(client.genre_search(genre: 'news').count).to eq(4)
      end

      it 'returns station instances' do
        expect(client.genre_search(genre: 'news').first).to be_a(
          Shoutcast::Api::Station
        )
      end
    end
  end
end
