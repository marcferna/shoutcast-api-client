require 'spec_helper'

describe Shoutcast::Api::Station do

  context '#parse' do
    let(:id) { '1234' }
    let(:name) { 'Rac1' }
    let(:mt) { 'audio/mpeg' }
    let(:br) { '128' }
    let(:genre) { 'News' }
    let(:genre2) { 'Catalan' }
    let(:ct) { 'El Mon a Rac1' }
    let(:lc) { '1987' }
    let(:logo) { 'http://rac1.org/logo.png' }

    let(:attributes) {
      {
        '@id'     => id,
        '@name'   => name,
        '@mt'     => mt,
        '@br'     => br,
        '@genre'  => genre,
        '@genre2' => genre2,
        '@ct'     => ct,
        '@lc'     => lc,
        '@logo'   => logo
      }
    }

    let(:station) { Shoutcast::Api::Station.parse(attributes) }

    it 'parses the id' do
      expect(station.id).to eq(id)
    end

    it 'parses the name' do
      expect(station.name).to eq(name)
    end

    it 'parses the mt' do
      expect(station.mt).to eq(mt)
    end

    it 'parses the br' do
      expect(station.br).to eq(br)
    end

    it 'parses the genres' do
      expect(station.genres).to eq([genre, genre2])
    end

    it 'parses the ct' do
      expect(station.ct).to eq(ct)
    end

    it 'parses the lc' do
      expect(station.lc).to eq(lc)
    end

    it 'parses the logo' do
      expect(station.logo).to eq(logo)
    end
  end
end
