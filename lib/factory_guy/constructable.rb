module FactoryGuy
  module Constructable
    ## DSL ##
    #extend FactoryGuy::Constructable

    # Only need to define #default_attributes
    # def default_attributes ; end

    def self.extended(mod)
      binding.pry
      # get the resource name from the factory class
      # so we know what class to call .build, etc. on
    end

    def attribute(name, value)
      attributes[name] = value
    end

    def build
      binding.pry
      resource.build(attributes)
    end

    def create
      resource.create(attributes)
    end

    def create!
      resource.create! attributes
    end
  end
end
