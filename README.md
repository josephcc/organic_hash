Organic Hash
============

Converts strings to awesome scifi objects!!

Organic Hash hashes strings (user ID, hashes) to a human-readable, scifi-themed
representation.

## Usage

Basic usage

    > require 'organic_hash'
    > oh = OrganicHash.new
    > oh.hash 'josephcc'
	=> "truthfully-better-explosion"
    > oh.hash 'josephcc', true
	=> ["truthfully", "better", "explosion"]
	> oh.hash 'asldkjasldkjasdlkajsd'
	=> "so-confident-turret"

Different length

    > oh = OrganicHash.new(4)
	> oh.hash 'Zero'
	=> "morally-unexpected-private-commander"

Random hashes
    
	> oh = OrganicHash.new(4)
	> oh.rand
	> oh.rand true





