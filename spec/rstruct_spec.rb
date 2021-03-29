require 'rstruct'

# rubocop:disable Lint/ConstantDefinitionInBlock
RSpec.describe(RStruct) {
  it('works with required and optional fields') {
    MyRStruct = RStruct.new(:one, %i[two three]) {
      def say_hi
        'Hello'
      end
    }

    my_instance = MyRStruct.new(1, 2)
    expect(my_instance.one).to(eq(1))
    expect(my_instance.two).to(eq(2))
    expect(my_instance.three).to(be(nil))
    expect(my_instance.say_hi).to(eq('Hello'))

    expect { MyRStruct.new }.to(raise_error(ArgumentError))
    expect { MyRStruct.new(1, 2, 3, 4) }.to(raise_error(ArgumentError))
  }

  it('lets you set defaults') {
    MyRStructWithDefaults = RStruct.new(:one, %i[two three]) {
      def initialize(one, two = 2, three = 3)
        super(one, two, three)
      end
    }

    my_instance = MyRStructWithDefaults.new(1)
    expect(my_instance.one).to(eq(1))
    expect(my_instance.two).to(eq(2))
    expect(my_instance.three).to(eq(3))
  }

  it('works with no optionals') {
    MyRStructAllRequired = RStruct.new(:one, :two, :three)

    my_instance = MyRStructAllRequired.new(1, 2, 3)
    expect(my_instance.one).to(eq(1))
    expect(my_instance.two).to(eq(2))
    expect(my_instance.three).to(eq(3))

    expect { MyRStructAllRequired.new }.to(raise_error(ArgumentError))
    expect { MyRStructAllRequired.new(1) }.to(raise_error(ArgumentError))
    expect { MyRStructAllRequired.new(1, 2) }.to(raise_error(ArgumentError))
    expect { MyRStructAllRequired.new(1, 2, 3, 4) }.to(
        raise_error(ArgumentError))
  }

  it('works with all optionals') {
    MyRStructAllOptional = RStruct.new(%i[one two three])

    my_instance = MyRStructAllOptional.new
    expect(my_instance.one).to(be(nil))
    expect(my_instance.two).to(be(nil))
    expect(my_instance.three).to(be(nil))

    my_instance = MyRStructAllOptional.new(1, 2)
    expect(my_instance.one).to(eq(1))
    expect(my_instance.two).to(eq(2))
    expect(my_instance.three).to(be(nil))

    expect { MyRStructAllOptional.new(1, 2, 3, 4) }.to(
        raise_error(ArgumentError))
  }
}
# rubocop:enable Lint/ConstantDefinitionInBlock
