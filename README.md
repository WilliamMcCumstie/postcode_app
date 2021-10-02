[![Build Status](https://app.travis-ci.com/WilliamMcCumstie/postcode_app.svg?branch=master)](https://app.travis-ci.com/WilliamMcCumstie/postcode_app)

# README

A basic application to check if a postcode is within the given service area.

## Prerequisites

This application requires the following:

* `ruby` version 2.6.5, and
* `bundler` version 2.2.28

## Installation

Run the following to install the application:

```
git clone https://github.com/WilliamMcCumstie/postcode_app
cd postcode_app
bundle install
```

## Configuration

This application does not require any database configuration. Instead the allowed postcodes are specified within a YAML configuration file. The `development` configuration file can be found [here](config/settings/development.yml).

The `production` server can be configured by first creating a local config:

```
touch config/settings/production.local.yml
```

The allowed postcodes can be configured via two keys. Both of which take an array of values:

* `shortened_lsoas`: The first section of the _Lower Layer Super Output Area_ (e.g. `Lambeth`), or
* `allowed_postcodes`: A static list of additional postcodes (regardless of lsoa).

NOTE: Both keys will need to be set before the server will start in `production`. An empty array `[]` should be used if a particular key is not applicable.

NOTE: The `allowed_postcodes` is not case sensitive.

## Running the server

The `production` server can be started with:

```
bundle exec rails server -e production
```

The server can than be accessed on:

`http://localhost:3000`

## Running the test suite

The tests can be ran with:

```
bundle exec rspec
```

# License

Copyright 2021 William McCumstie

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
