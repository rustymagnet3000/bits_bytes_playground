
### calling a block

```ruby
def make_salad
  yield "lettuce"
  yield "carrots"
  yield "olive oil"
end

make_salad { |ingredient| puts "Adding #{ingredient} to salad!" }
```