# Rstruct

A simpler, cleaner version of Ruby Structs, with required params.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rstruct', git: 'https://github.com/jubishop/rstruct'
```

And then execute:

$ bundle install

## Usage

RStruct provides two class definitions:  `RStruct` and `KVStruct`.

### RStruct

`RStruct` defines a Struct that takes a flat list of parameters to its constructor.

All required params:  `MyStruct = RStruct.new(:one, :two, :three)`

All optional params:  `MyStruct = RStruct.new([:one, :two, :three])`

First param required:  `MyStruct = RStruct.new(:one, [:two, :three])`

You can of course open the classes to define additional functions, just like normal Structs:

```ruby
MyStruct = RStruct.new(:one, [:two, :three]) {
    def sayHi
        "Hello"
    end
}
```

Creating a MyStruct works as you'd expect:

```ruby
myInstance = MyStruct.new(1) # :two and :three are optional
myInstanc.sayHi # "Hello"
```

### KVStruct

`KVStruct` defines a Struct that takes key value pairs.

All required params:  `MyStruct = KVStruct.new(:one, :two, :three)`

All optional params:  `MyStruct = KVtruct.new([:one, :two, :three])`

First param required:  `MyStruct = KVtruct.new(:one, [:two, :three])`

Creating these now requires key-value pairs:

```ruby
myInstance = MyStruct.new(one: 1) # :two and :three are optional
```

### More examples

See the code in [RLBot](https://github.com/jubishop/RLBot) for example uses.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jubishop/rstruct. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/jubishop/rstruct/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rstruct project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rstruct/blob/master/CODE_OF_CONDUCT.md).
