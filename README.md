[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/GalenkoNeon/CodeBreaker/blob/master/LICENSE.txt)
[![Build Status](https://travis-ci.org/GalenkoNeon/CodeBreaker.svg?branch=dev)](https://travis-ci.org/GalenkoNeon/CodeBreaker)
# Codebreaker

[Codebreaker](https://rubygarage.github.io/slides/rspec#/37/1) is a logic game in which a code-breaker tries to break a secret code created by a code-maker. The code-maker, which will be played by the application we’re going to write, creates a secret code of four numbers `between 1 and 6`.


The code-breaker then gets some number of chances to break the code. In each turn, the code-breaker makes a guess of four numbers. The code-maker then marks the guess with up to four `+` and `-` signs.


A `+` indicates an exact match: one of the numbers in the guess is the same as one of the numbers in the secret code and in the same position.


A `-` indicates a number match: one of the numbers in the guess is the same as one of the numbers in the secret code but in a different position.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'codebreaker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install codebreaker

## Usage

```ruby
require_relative 'codebreaker'
require_relative 'codebreaker/ui'
# User Interface for testing CogeBreaker module
module UI
  game = Codebreaker::Game.new
  result = ''
  @name = false
  UI.help

  loop do
    @name = UI.name unless @name
    UI.start if game.start

    loop do
      user_option = UI.capture_guess(game)
      p game.hint if %w[h help hint].include? user_option
      next if user_option !~ /^[1-6]{4}$/
      p result = game.compare_with(user_option)
      break if game.attempts.zero? || result == '++++'
    end

    result == '++++' ? UI.won(@name, game.attempts) : UI.lost
    game.save(@name) if UI.save?
    break unless UI.repeat_game?
  end
  UI.bye
  UI.show(game.score)
end
```
  ![Alt text](https://snag.gy/BnFZNX.jpg 'example of data.yaml')
  ![Alt text](https://snag.gy/8gX25p.jpg 'Read from file..')

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/GalenkoNeon/codebreaker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
