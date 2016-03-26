module FactoryGuy
  ImplementationError = Class.new(StandardError)

  module Constructable
    ## DSL ##
    # class SomeFactory
    #   extend FactoryGuy::Constructable

    # Need to define #default_attributes
    # def default_attributes ; end

    def self.extended(mod)
      mod.class_eval do
        cattr_accessor :resource

        resource_name = mod.to_s.split(/Factory/)[0]
        self.resource = const_get(resource_name)
      end
    end

    def attributes
      begin
        default_attributes
      rescue NameError
        raise(ImplementationError, "Your factory must implement class-level `#{self}.default_attributes`.")
      end
    end

    def build
      resource.new(attributes)
    end

    def create
      build.tap(&:save)
    end

    def create!
      build.tap(&:save!)
    end

    def create_list(n, options = {})
      resource.create(
        n.times.map { attributes.merge(options) }
      )
    end
  end
end
