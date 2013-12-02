
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


require 'where_builder'       <br>
f = WhereBuilder::WhereBuilder.new()       <br>
where = f.build(       <br>
  f.add('a.name = ?', 'zd'),        <br>
  f.OR('a.id=?', 1),        <br>
  f.AND,       <br>
  f.bracket(       <br>
      f.add('key like ?', 'zd'),        <br>
      f.AND('value=?', '2')       <br>
    )       <br>
  )       <br>

puts "where=#{where}"       <br>

output:
where=["WHERE a.name = ? OR a.id=? AND ( key like ? AND value=?)", ["zd", 1, "zd", "2"]]       <br>
=> nil       <br>

==============================
where = f.build(       <br>
  f.add('a.name = b.name'),        <br>
  f.OR('a.id=?', 1),        <br>
  f.AND,       <br>
  f.bracket(       <br>
      f.add('key like ?', 'zd'),        <br>
      f.AND('value=?', '2')       <br>
    )       <br>
  )       <br>
=> ["WHERE a.name = b.name OR a.id=? AND ( key like ? AND value=?)", [1, "zd", "2"]]       <br>


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

