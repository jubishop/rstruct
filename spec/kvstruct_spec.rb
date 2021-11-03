require 'rstruct'

RSpec.describe(KVStruct) {
  it('works with required and optional fields') {
    MyKVStruct = KVStruct.new(:one, %i[two three]) {
      def say_hi
        'Hello'
      end
    }

    my_instance = MyKVStruct.new(one: 1, two: 2)
    expect(my_instance.one).to(eq(1))
    expect(my_instance.two).to(eq(2))
    expect(my_instance.three).to(be(nil))
    expect(my_instance.say_hi).to(eq('Hello'))

    expect { MyKVStruct.new }.to(raise_error(ArgumentError))

    expect { MyKVStruct.new(1, 2) }.to(raise_error(ArgumentError))
    expect { MyKVStruct.new(four: 4) }.to(raise_error(ArgumentError))
  }

  it('lets you set defaults on hash') {
    MyKVStructWithDefaultArgs = KVStruct.new(:one, %i[two three]) {
      def initialize(args)
        args[:two] = args.fetch(:two, 4)
        args[:three] = args.fetch(:three, 3)
        super(args)
      end
    }

    my_instance = MyKVStructWithDefaultArgs.new(one: 1, two: 2)
    expect(my_instance.one).to(eq(1))
    expect(my_instance.two).to(eq(2))
    expect(my_instance.three).to(eq(3))

    expect { MyKVStructWithDefaultArgs.new(1, 2) }.to(
        raise_error(ArgumentError))
    expect { MyKVStructWithDefaultArgs.new(four: 4) }.to(
        raise_error(ArgumentError))
  }

  it('lets you set defaults on params') {
    MyKVStructWithDefaultParams = KVStruct.new(:one, %i[two three]) {
      def initialize(one:, two: 'two', three: 'three')
        super(one: one, two: two, three: three)
      end
    }

    my_instance = MyKVStructWithDefaultParams.new(one: 1, two: 4)
    expect(my_instance.one).to(eq(1))
    expect(my_instance.two).to(eq(4))
    expect(my_instance.three).to(eq('three'))

    expect { MyKVStructWithDefaultParams.new(1, 2) }.to(
        raise_error(ArgumentError))
    expect { MyKVStructWithDefaultParams.new(four: 4) }.to(
        raise_error(ArgumentError))
  }

  it('works with no optionals') {
    MyKVStructAllRequired = KVStruct.new(:one, :two, :three)

    my_instance = MyKVStructAllRequired.new(one: 1, two: 2, three: 3)
    expect(my_instance.one).to(eq(1))
    expect(my_instance.two).to(eq(2))
    expect(my_instance.three).to(eq(3))

    expect { MyKVStructAllRequired.new }.to(raise_error(ArgumentError))
    expect { MyKVStructAllRequired.new(one: 1) }.to(raise_error(ArgumentError))
    expect { MyKVStructAllRequired.new(one: 1, two: 2) }.to(
        raise_error(ArgumentError))

    expect { MyKVStructAllRequired.new(1, 2) }.to(raise_error(ArgumentError))
    expect { MyKVStructAllRequired.new(four: 4) }.to(
        raise_error(ArgumentError))
  }

  it('works with all optionals') {
    MyKVStructAllOptional = KVStruct.new(%i[one two three])

    my_instance = MyKVStructAllOptional.new
    expect(my_instance.one).to(be(nil))
    expect(my_instance.two).to(be(nil))
    expect(my_instance.three).to(be(nil))

    my_instance = MyKVStructAllOptional.new(one: 1, two: 2)
    expect(my_instance.one).to(eq(1))
    expect(my_instance.two).to(eq(2))
    expect(my_instance.three).to(be(nil))

    expect { MyKVStructAllOptional.new(1, 2) }.to(raise_error(ArgumentError))
    expect { MyKVStructAllOptional.new(four: 4) }.to(
        raise_error(ArgumentError))
  }
}
