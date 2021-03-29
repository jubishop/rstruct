require 'set'

require 'core'

class KVStruct < Struct
  def self.new(*args, &block)
    required = args.last.is_a?(Array) ? args[0...-1] : args
    optional = args.last.is_a?(Array) ? args.last : []
    argument_intersection = required.intersection(optional)
    unless argument_intersection.empty?
      raise ArgumentError, 'Required and optional keys to overlap: ' \
        "#{argument_intersection.to_a.sentence}"
    end

    super(*args.flatten, keyword_init: true) {
      @required, @optional = required.to_set, optional.to_set
      @all_arguments = @required + optional
      def self.required # rubocop:disable Lint/NestedMethodDefinition
        return @required
      end

      def self.optional # rubocop:disable Lint/NestedMethodDefinition
        return @optional
      end

      def self.all_arguments # rubocop:disable Lint/NestedMethodDefinition
        return @all_arguments
      end
      class_eval(&block) unless block.nil?
    }
  end

  def initialize(args = {}) # rubocop:disable Style/OptionHash
    unless args.is_a?(Hash)
      raise ArgumentError, "Params to #{self.class}.new must be key: value " \
        'pairs'
    end

    missing_required = self.class.required - args.keys
    unless missing_required.empty?
      raise ArgumentError, "Required keys: #{missing_required.to_a.sentence} " \
        "were not passed to #{self.class}.new."
    end

    if args.keys.length > self.class.all_arguments.size
      unexpected_params = args.keys.to_set - self.class.all_arguments
      raise ArgumentError, 'Unexpected keys: ' \
        "#{unexpected_params.to_a.sentence} were passed to #{self.class}.new."
    end

    super(args)
  end
end

class RStruct < Struct
  def self.new(*args, &block)
    num_required = args.last.is_a?(Array) ? args.length - 1 : args.length
    num_possible = args.flatten.length

    super(*args.flatten, keyword_init: false) {
      @param_range = (num_required..num_possible)
      def self.param_range # rubocop:disable Lint/NestedMethodDefinition
        return @param_range
      end
      class_eval(&block) unless block.nil?
    }
  end

  def initialize(*args)
    unless self.class.param_range.include?(args.length)
      raise ArgumentError, "#{self.class.param_range} params must be passed " \
        "to #{self.class}.new."
    end

    super(*args)
  end
end
