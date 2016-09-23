# SHOUTcast API Client
[![Build Status](https://travis-ci.org/marcferna/shoutcast-api-client.svg?branch=master)](https://travis-ci.org/marcferna/shoutcast-api-client) [![Code Climate](https://codeclimate.com/github/marcferna/shoutcast-api-client/badges/gpa.svg)](https://codeclimate.com/github/marcferna/shoutcast-api-client) [![Test Coverage](https://codeclimate.com/github/marcferna/shoutcast-api-client/badges/coverage.svg)](https://codeclimate.com/github/marcferna/shoutcast-api-client/coverage) [![Dependency Status](https://gemnasium.com/badges/github.com/marcferna/shoutcast-api-client.svg)](https://gemnasium.com/github.com/marcferna/shoutcast-api-client) [![Gem Version](https://badge.fury.io/rb/shoutcast-api-client.svg)](https://badge.fury.io/rb/shoutcast-api-client)

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
- [x] Keyword Search
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
```ruby
$ bundle
```
Or install it yourself as:
```
$ gem install shoutcast-api-client
```
## Usage

### Initialization

First need to initialize the client with your SHOUTcast API key

```ruby
client = Shoutcast::Api::Client.new(key: 'YOUR_API_KEY_GOES_HERE')
```

### Top 500
Get top 500 stations on SHOUTcast Radio directory.
```ruby
client.top_500
```

Returns an array of [Stations](lib/shoutcast/api/station.rb):
```ruby
[
  <Shoutcast::Api::Station:0x007fb3c40361d0 @id="9907", @name=".977 The Hitz Channel-[SHOUTcast.com]", @mt="audio/mpeg", @br="128", @genres=["Pop Rock Top 40"], @ct="The Fray - You Found Me", @lc="4670", @logo=nil>,
  <Shoutcast::Api::Station:0x007fb3c5840b68 @id="120149", @name="HOT FM - Lebih Hangat Daripada Biasa : HOT fm-[SHOUTcast.com]", @mt="audio/mpeg", @br="24", @genres=["Malaysia Malay"], @ct="LELAKI IDAMAN MELLY_GOESLOW ", @lc="3961", @logo=nil>,
  <Shoutcast::Api::Station:0x007fb3c583bf50 @id="1264", @name="S K Y . F M - Absolutely Smooth Jazz - the world's smoothest jazz 24 hours a day-[SHOUTcast.com]", @mt="audio/mpeg", @br="96", @genres=["Soft Smooth Jazz"], @ct="Oli Silk - De-stress Signal", @lc="3507", @logo=nil>,
  <Shoutcast::Api::Station:0x007fb3c583b6b8 @id="6687", @name="Groove Salad: a nicely chilled plate of ambient beats and grooves. [SomaFM]-[SHOUTcast.com]", @mt="audio/mpeg", @br="128", @genres=["Ambient Chill"], @ct="Verbrilli Sound - Descender", @lc="2680", @logo=nil>,
  <Shoutcast::Api::Station:0x007fb3c583ae70 @id="6803", @name=".977 The 80s Channel-[SHOUTcast.com]", @mt="audio/mpeg", @br="128", @genres=["80s Pop Rock"], @ct="Starship - Nothing`s gonna stop us now (1987)", @lc="2192", @logo=nil>,
  <Shoutcast::Api::Station:0x007fb3c583a588 @id="5516", @name="The Alex Jones Show-[SHOUTcast.com]", @mt="audio/mpeg", @br="32", @genres=["Talk"], @ct="Refeed: Hour 1 (Listen by phone 512-646-5000)", @lc="1987", @logo=nil>
]
```


### Station Search
Get stations which match the keyword searched on SHOUTcast Radio Directory.
```ruby
client.search(
    keyword:    'SEARCH_KEYWORD', 
    limit:      PAGE_COUNT_LIMIT, 
    offset:     PAGE_OFFSET, 
    bitrate:    STATION_BITRATE, 
    media_type: 'STATION_MEDIA_TYPE'
)
```

#### Parameters
`keyword`: The keyword to search stations for. Matches on Station Name, Now Playing info and Genre.

`limit`: The number of results to be returned by page.

`offset`: Specifies the number of the first station to return in the results. 

`bitrate`: Station bitrate to search for. Ex: "128", "96".

`media_type`: The media type to search for. Ex: "audio/mpeg" or "audio/aacp"

Returns an array of [Stations](lib/shoutcast/api/station.rb):
```ruby
[
  <Shoutcast::Api::Station:0x007fb3c40361d0 @id="9907", @name=".977 The Hitz Channel-[SHOUTcast.com]", @mt="audio/mpeg", @br="128", @genres=["Pop Rock Top 40"], @ct="The Fray - You Found Me", @lc="4670", @logo=nil>,
  <Shoutcast::Api::Station:0x007fb3c5840b68 @id="120149", @name="HOT FM - Lebih Hangat Daripada Biasa : HOT fm-[SHOUTcast.com]", @mt="audio/mpeg", @br="24", @genres=["Malaysia Malay"], @ct="LELAKI IDAMAN MELLY_GOESLOW ", @lc="3961", @logo=nil>,
  <Shoutcast::Api::Station:0x007fb3c583bf50 @id="1264", @name="S K Y . F M - Absolutely Smooth Jazz - the world's smoothest jazz 24 hours a day-[SHOUTcast.com]", @mt="audio/mpeg", @br="96", @genres=["Soft Smooth Jazz"], @ct="Oli Silk - De-stress Signal", @lc="3507", @logo=nil>,
  <Shoutcast::Api::Station:0x007fb3c583b6b8 @id="6687", @name="Groove Salad: a nicely chilled plate of ambient beats and grooves. [SomaFM]-[SHOUTcast.com]", @mt="audio/mpeg", @br="128", @genres=["Ambient Chill"], @ct="Verbrilli Sound - Descender", @lc="2680", @logo=nil>,
  <Shoutcast::Api::Station:0x007fb3c583ae70 @id="6803", @name=".977 The 80s Channel-[SHOUTcast.com]", @mt="audio/mpeg", @br="128", @genres=["80s Pop Rock"], @ct="Starship - Nothing`s gonna stop us now (1987)", @lc="2192", @logo=nil>,
  <Shoutcast::Api::Station:0x007fb3c583a588 @id="5516", @name="The Alex Jones Show-[SHOUTcast.com]", @mt="audio/mpeg", @br="32", @genres=["Talk"], @ct="Refeed: Hour 1 (Listen by phone 512-646-5000)", @lc="1987", @logo=nil>
]
```


## Contributing

See [CONTRIBUTING](CONTRIBUTING.md)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

