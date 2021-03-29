# RStruct

[![RSpec Status](https://github.com/jubishop/rstruct/workflows/RSpec/badge.svg)](https://github.com/jubishop/rstruct/actions/workflows/rspec.yml)  [![Rubocop Status](https://github.com/jubishop/rstruct/workflows/Rubocop/badge.svg)](https://github.com/jubishop/rstruct/actions/workflows/rubocop.yml)

A cleaner, simpler version of Ruby Structs.

## Installation

### Global installation

```zsh
gem install rstruct --source https://www.jubigems.org/
```

### In a Gemfile

```ruby
gem 'rstruct', source: 'https://www.jubigems.org/'
```

## Usage

RStruct provides two class definitions:  `RStruct` and `KVStruct`.

### RStruct

`RStruct` defines a Struct that takes a flat list of parameters to its constructor.

All required params:  `MyStruct = RStruct.new(:one, :two, :three)`

All optional params:  `MyStruct = RStruct.new([:one, :two, :three])`

First param required:  `MyStruct = RStruct.new(:one, [:two, :three])`

You can of course open the classes to define additional functions, just like normal Structs:

```ruby
MyStruct = RStruct.new(:one, %i[two three]) {
  def say_hi
    "Hello"
  end
}
```

Creating a MyStruct works as you'd expect:

```ruby
my_instance = MyStruct.new(1) # :two and :three are optional
my_instance.say_hi # "Hello"
```

If you want to define default values for the optional params, you can override `initialize`:

```ruby
MyStruct = RStruct.new(:one, %i[two three]) {
  def initialize(one, two = 2, three = nil)
    super(one, two, three)
  end
}
```

Now when you create a mystruct, `.two` will have the default value `2`, but `.three` will still be `nil`:

```ruby
myInstance = MyStruct.new(1)
myInstance.two # 2
myInstance.three # nil
```

### KVStruct

`KVStruct` defines a Struct that takes key value pairs.

All required params:  `MyStruct = KVStruct.new(:one, :two, :three)`

All optional params:  `MyStruct = KVStruct.new([:one, :two, :three])`

First param required:  `MyStruct = KVStruct.new(:one, [:two, :three])`

Creating these now requires key-value pairs:

```ruby
myInstance = MyStruct.new(one: 1) # :two and :three are optional
```

You could also define defaults for these in `initialize` too:

```ruby
MyStruct = KVStruct.new(:one, :two, [:three]) {
  def initialize(one:, two:, three: 'three')
    super(one: one, two: two, three: three)
  end
}
```

then:

```ruby
myInstance = KVStruct(one: 1, two: 2)
myInstance.three # "three"
```

You can also define the defaults directly to the args as a Hash:

```ruby
MyStruct = KVStruct.new(:one, :two, [:three]) {
  def initialize(args)
    args[:three] = args.fetch(:three, "three")
    super(args)
  end
}
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
