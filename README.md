
# WhereBuilder

  use this tool can build a where sentence for sql, it's can ignore a condition when it's para is nil or black string.
  my purpose is not check nil for every condition, don't repeat so much if else.

## Installation

Add this line to your application's Gemfile:

    gem 'where_builder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install where_builder

## Usage


irb> require 'where_builder'       <br>
=> true       <br>
irb> f = WhereBuilder::WhereBuilder.new()       <br>
=> #<WhereBuilder::WhereBuilder:0x007f80f0983258>       <br>
irb> where = f.build(       <br>
irb*   f.add('a.name = ?', 'zd'),        <br>
irb*   f.OR('a.id=?', 1),        <br>
irb*   f.AND,       <br>
irb*   f.bracket(       <br>
irb*       f.add('key like ?', 'zd'),        <br>
irb*       f.AND('value=?', '2')       <br>
irb>     )       <br>
irb>   )       <br>
=> ["WHERE a.name = ? OR a.id=? AND ( key like ? AND value=?)", ["zd", 1, "zd", "2"]]       <br>
irb>        <br>
irb* puts "where=#{where}"       <br>
where=["WHERE a.name = ? OR a.id=? AND ( key like ? AND value=?)", ["zd", 1, "zd", "2"]]       <br>
=> nil       <br>

==============================
irb> where = f.build(       <br>
irb*   f.add('a.name = b.name'),        <br>
irb*   f.OR('a.id=?', 1),        <br>
irb*   f.AND,       <br>
irb*   f.bracket(       <br>
irb*       f.add('key like ?', 'zd'),        <br>
irb*       f.AND('value=?', '2')       <br>
irb>     )       <br>
irb>   )       <br>
=> ["WHERE a.name = b.name OR a.id=? AND ( key like ? AND value=?)", [1, "zd", "2"]]       <br>


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

