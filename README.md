# SHOUTcast API Client
[![Build Status](https://travis-ci.org/marcferna/shoutcast-api-client.svg?branch=master)](https://travis-ci.org/marcferna/shoutcast-api-client) [![Code Climate](https://codeclimate.com/github/marcferna/shoutcast-api-client/badges/gpa.svg)](https://codeclimate.com/github/marcferna/shoutcast-api-client) [![Test Coverage](https://codeclimate.com/github/marcferna/shoutcast-api-client/badges/coverage.svg)](https://codeclimate.com/github/marcferna/shoutcast-api-client/coverage) [![Dependency Status](https://gemnasium.com/badges/github.com/marcferna/shoutcast-api-client.svg)](https://gemnasium.com/github.com/marcferna/shoutcast-api-client)

:exclamation:**Important - You will need a SHOUTcast API key for this gem to work. You can request one from their [developer website](https://www.shoutcast.com/Developer)**

:warning:  *Note - This gem is an early alpha and is still in development. Use at your own risk.*  :warning:

## Description
This gem provides a nice interface to interact with SHOUTcast’s API and also parses the XML response into Ruby objects.
You can find the full API documentation in [SHOUTcast’s official documentation page](http://wiki.winamp.com/wiki/SHOUTcast_Radio_Directory_API).

## Progress
This gem is an early alpha and is still in development. To see a more detailed
progress description you can check the [CHANGELOG.md](CHANGELOG.md)

### Stations

- [x] Top 500 (Passing parameters not implemented yet)
- [ ] Keyword Search
- [ ] Stations by Genre
- [ ] Stations by Now Playing Info
- [ ] Stations by Bitrate or Codec Type or Genre ID
- [ ] Random Stations

### Genres

- [ ] All Genres
- [ ] Primary Genres
- [ ] Secondary Genres
- [ ] Genres Details by Passing Genreid
- [ ] Genres Based on Availability of Sub-Genres

## Installation

Add this line to your application’s Gemfile:

```ruby
gem 'shoutcast-api-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shoutcast-api-client

## Usage

TODO: Write usage instructions here

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

