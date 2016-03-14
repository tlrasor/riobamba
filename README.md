## Riobamba README

[![Build Status](https://travis-ci.org/tlrasor/riobamba.svg?branch=master)](https://travis-ci.org/tlrasor/riobamba)

### Introduction

Riobamba is a simple (lol) URL shortening service written in Ruby with Sinatra
at its core. It comes complete with the actual shortening service, JSON API,
and simple Admin site.

### Requirements

Ruby 2.2.3 (tested)
bundler and rake gems
bower (and therefore npm)

### Install

The install uses Bundler, Rake, and Bower. It should go something like this 
(assuming you already have ruby, bundler, npm, and bower installed):

```Bash
bundle install
bundle exec rake Build:all
```

### Tests

There are at least two tests, I swear. You can run them with rake

```Bash
bundle exec rake Test:all
```

### Running

There is a config.ru file for use with rack, just use rackup

```Bash
bundle exec rackup
```

### Contribute

Pull requests are welcome, commentary is welcome.

### License

[Beerware](https://en.wikipedia.org/wiki/Beerware)
