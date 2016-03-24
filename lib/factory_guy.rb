require "factory_guy/version"

module FactoryGuy
  class << self
    def next(attr, attr_string = nil)
      count = count_for(attr)
      count += 1
      update_counter_hash!(attr, count)
      block = sequencer[attr]
      block ? block.call(count, attr_string) : raise("Sequence for :#{attr} is undefined.")
    end

    def sequence(attr, &block)
      sequencer[attr] = block
    end

    private

    def count_for(attr)
      counter_hash[attr] || 0
    end

    def update_counter_hash!(attr, count)
      counter_hash[attr] = count
    end

    def counter_hash
      @counter_hash ||= {}
    end

    def sequencer
      @sequencer ||= {}
    end
  end
end

if defined? Rails
  Dir[Rails.root.join("spec/factories/**/*_factory.rb")].each { |f| require f }
end
