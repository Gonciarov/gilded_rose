# Specification

Famous 'Gilded Rose' kata in which you refactor legacy code with multiple nested 'ifs' and 'elses' into something readable and extendable. Find details [here](specification.md).

# Run

Clone this repo and run in irb.

This is an example of what manager of Gilded Rose sees when they come to update their stock info:
```
$ irb
$ :001 > require './lib/gilded_rose.rb'
 => true
$ :002 > items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 40)]
 => [#<Item:0x00007fd2149fbb70 @name="Backstage passes to a TAFKAL80ETC concert", @sell_in=9, @quality=40>]
$ :003 > GildedRose.new(items).update_quality()
 => [#<Item:0x00007fd2149fbb70 @name="Backstage passes to a TAFKAL80ETC concert", @sell_in=8, @quality=42>]
```
# Tests
```
$ bundle
$ rspec
```

# Approach
- First of all, I tested all existing functionality.
- Next, added tests for new ('Conjured') items.
- Refactored legacy code making sure methods hold single responsibility.
- Added code for new ('Conjured') items.
