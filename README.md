# WulinPermits

WulinPermits is for permission management. You can create roles and configuration permission for each role.
And then you can assign role to user.

## Installation

Add this line to your application's Gemfile:

    gem 'wulin_permits'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wulin_permits

## Usage

What you need to do is defind admin email for application in config/initializers

like: 

    # config/initializers/wulin_permits.rb
    WulinPermits.admin = 'admin@explame.com'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
