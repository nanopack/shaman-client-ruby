# Shaman

A Ruby client for interacting with the [shaman](https://github.com/nanopack/shaman) service.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shaman'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shaman

## Usage

#### Client

Instantiate a client, providing the IP of the host and the security token:
```ruby

client = Shaman::Client.new('127.0.0.1', 'secret')

```

#### Domain Records

List all of the registered dns records:
```ruby
client.records
```

Fetch information about a particular record:
```ruby
client.record('nanobox.io')
```

Add a new domain record:
```ruby
client.add_record({
    domain: 'nanobox.io',     # Domain name to resolve
    records: [
      ttl: 60,                # Seconds a client should cache for
      class: 'IN',            # Record class
      type: 'A',              # Record type (A, CNAME, MX, etc)
      address: '127.0.0.1'    # Address domain resolves to
    ]
})
```

Update a registered domain record:
```ruby
client.update_record('nanobox.io', {
  domain: 'nanobox.io',     # Domain name to resolve
  records: [
    ttl: 60,                # Seconds a client should cache for
    class: 'IN',            # Record class
    type: 'A',              # Record type (A, CNAME, MX, etc)
    address: '127.0.0.1'    # Address domain resolves to
  ]
})
```

Remove a registered domain:
```ruby
client.remove_record('nanobox.io')
```

Reset all records:
```ruby
client.reset_records([
  {
    domain: 'nanobox.io',     # Domain name to resolve
    records: [
      ttl: 60,                # Seconds a client should cache for
      class: 'IN',            # Record class
      type: 'A',              # Record type (A, CNAME, MX, etc)
      address: '127.0.0.1'    # Address domain resolves to
    ]
  },
  {
    domain: 'gonano.io',     # Domain name to resolve
    records: [
      ttl: 60,                # Seconds a client should cache for
      class: 'IN',            # Record class
      type: 'A',              # Record type (A, CNAME, MX, etc)
      address: '127.0.0.1'    # Address domain resolves to
    ]
  }
])
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nanopack/shaman.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
