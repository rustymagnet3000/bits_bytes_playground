
https://ruby-doc.org/stdlib-2.6.3/libdoc/open3/rdoc/Open3.html#method-c-capture3
https://stackoverflow.com/questions/19303080/ruby-write-to-stdin-and-read-from-stdout/19303225

##### Happy Path

```ruby
o, e, s= Open3.capture3("cli_app get stuff", stdin_data: nil)
=> { nice json response }
irb(main):010:0> s.success?
=> true
irb(main):011:0> s.exitstatus
=> 0
```
irb(main):021:0> e
=> ""

##### Error Path

```ruby
o, e, s= Open3.capture3("eval $(cli_app login foobar)", stdin_data: "secret")


irb(main):013:0> s.success?=> true
irb(main):014:0> s.exitstatus=> 0
irb(main):017:0> e
=> "[ERROR] 2021/04/08 14:03:14 Authentication: Unauthorized\n"
```