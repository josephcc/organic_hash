Organic Hash
============

Converts strings to awesome scifi objects!!

Organic Hash hashes strings (user ID, hashes) to a human-readable, scifi-themed
representation.

## Demo

http://truly-civilized-pancakes.herokuapp.com

## Install

```bash
$ gem install organic_hash
```

## Usage

Basic usage

```ruby
> require 'organic_hash'
> oh = OrganicHash.new
> oh.hash 'ID_A3AHG7FKPIV07'
=> "technically-huge-witch"
> oh.hash 'asldkjasldkjasdlkajsd'
=> "so-confident-turret"
> oh.hash 'josephcc'
=> "truthfully-better-explosion"
> oh.hash 'josephcc', true
=> ["truthfully", "better", "explosion"]
```

Different length

```ruby
> oh = OrganicHash.new(4)
> oh.hash 'Zero'
=> "morally-unexpected-private-commander"
```

Random hashes
    
```ruby
> oh = OrganicHash.new
> oh.rand
=> "most-cool-coffee"
> oh.rand
=> "currently-upcoming-signals"
> oh.rand true
=> ["simultaneously", "automatic", "action"]
```

Class methods for quick access

```ruby
> OrganicHash.hash 'asdlkj'
=> "quite-unacceptable-genius"
> OrganicHash.rand
=> "emotionally-restricted-bombs"
```


## Authors

Joseph Chee Chang <josephcc.cmu@gmail.com> and Zero Cho <itszero@gmail.com>

## License

Apache License, Version 2.0

## URL

https://github.com/josephcc/organic_hash

http://rubygems.org/gems/organic_hash

