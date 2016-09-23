require 'spec_helper'

describe Shoutcast::Api::Url do
  context '#initialize' do
    it 'requires the path attribute' do
      expect { described_class.new(key: 'key') }.to raise_error(ArgumentError)
    end

    it 'requires the key attribute' do
      expect { described_class.new(path: 'path') }.to raise_error(ArgumentError)
    end

    it 'succeeds with a path and key attribute' do
      expect(described_class.new(path: 'path', key: 'key')).to be
    end
  end

  context '.to_s' do
    let(:url) {
      described_class.new(path: path, key: key, parameters: parameters)
    }
    let(:path) { '/api-path' }
    let(:key) { 'key' }
    let(:parameters) { nil }

    context 'path' do
      let(:parameters) { nil }

      context 'path with leading /' do
        let(:path) { '/api-path' }

        it 'removes leading slash' do
          expect(url.to_s).to eq('http://api.shoutcast.com/api-path?k=key')
        end
      end

      context 'path with trailing /' do
        let(:path) { 'api-path/' }

        it 'does not remove trailing slash' do
          expect(url.to_s).to eq('http://api.shoutcast.com/api-path/?k=key')
        end
      end

      context 'nested path' do
        let(:path) { 'legacy/api-path/' }

        it 'does not remove trailing slash' do
          expect(url.to_s).to eq(
            'http://api.shoutcast.com/legacy/api-path/?k=key'
          )
        end
      end
    end

    context 'parameters' do
      context 'multiple parameters' do
        let(:parameters) { { a: 1, b: 2 } }

        it 'adds parameters' do
          expect(url.to_s).to eq(
            'http://api.shoutcast.com/api-path?k=key&a=1&b=2'
          )
        end
      end

      context 'single parameter' do
        let(:parameters) { { a: 1 } }

        it 'adds parameter' do
          expect(url.to_s).to eq(
            'http://api.shoutcast.com/api-path?k=key&a=1'
          )
        end
      end

      context 'nil parameter' do
        let(:parameters) { { a: 1, b: nil } }

        it 'does not include nil parameter value' do
          expect(url.to_s).to eq(
            'http://api.shoutcast.com/api-path?k=key&a=1'
          )
        end
      end
    end
  end
end
