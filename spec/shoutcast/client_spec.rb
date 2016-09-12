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
        File.read('spec/fixtures/station_list_test_data.xml')
      }
    end

    it 'parses all the stations' do
      expect(client.top_500.count).to eq(6)
    end

    it 'returns station instances' do
      expect(client.top_500.first).to be_a(Shoutcast::Api::Station)
    end
  end
end
