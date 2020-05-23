class KVStruct < Struct
  def self.new(*args, &block)
    required = args.last.is_a?(Array) ? args[0...-1] : args
    super(*args.flatten, keyword_init: true) {
      @required = required
      def self.required
        return @required
      end
      class_eval(&block) unless block.nil?
    }
  end

  def initialize(args = {})
    self.class.required.each { |param|
      unless args.key?(param) || args.key?(param.to_s)
        raise ArgumentError, "Required param: #{param} is missing from " \
          "#{self.class} constructor."
      end
    }
    super(args)
  end
end

class RStruct < Struct
  def self.new(*args, &block)
    num_required = args.last.is_a?(Array) ? args.length - 1 : args.length
    super(*args.flatten, keyword_init: false) {
      @num_required = num_required
      def self.num_required
        return @num_required
      end
      class_eval(&block) unless block.nil?
    }
  end

  def initialize(*args)
    if args.length < self.class.num_required
      raise ArgumentError, "#{self.class.num_required} params required in " \
        "#{self.class} constructor."
    end
    super(*args)
  end
end
