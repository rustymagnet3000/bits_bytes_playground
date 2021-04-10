
https://ruby-doc.org/stdlib-2.6.3/libdoc/open3/rdoc/Open3.html#method-c-capture3
https://stackoverflow.com/questions/19303080/ruby-write-to-stdin-and-read-from-stdout/19303225

### Shell commands

```ruby
puts %x{ls -al}
puts(`ls -l`)
```

### Open3.capture3

```ruby
irb(main):016:0> o, e, s = Open3.capture3("echo abc; sort >&2", :stdin_data=>"foo\nbar\nbaz\n")
=> ["abc\n", "bar\nbaz\nfoo\n", #<Process::Status: pid 55698 exit 0>]
```

### Open3.pipeline_w

Open3.pipeline_w("bzip2 -c", :out=>"/tmp/hello.bz2") {|i, ts|
  i.puts "hello"
}

### Open3.pipeline

```ruby
irb(main):010:0> status_list = Open3.pipeline(["echo", "boo"])
boo
=> [#<Process::Status: pid 55685 exit 0>]
irb(main):011:0> puts(status_list)
pid 55685 exit 0
=> nil
```

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