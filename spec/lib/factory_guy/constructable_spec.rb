require 'spec_helper'

class Shoe < Struct.new(:foo, :persisted)
  def initialize(options = {})
    super(options[:foo])
  end

  def save
    self.persisted = true
  end

  def persisted?
    !!persisted
  end
end

class ShoeFactory
  class << self
    def default_attributes
      {
        foo: "bar"
      }
    end

    def cattr_accessor(attr)
      define_singleton_method(attr) do
        instance_variable_get("@#{attr}")
      end

      define_singleton_method("#{attr}=") do |val|
        instance_variable_set("@#{attr}", val)
      end
    end

  end

  extend FactoryGuy::Constructable
end

RSpec.describe FactoryGuy::Constructable do
  describe "#create" do
    subject { ShoeFactory.create }

    it "persists the record" do
      expect(subject.persisted?).to eq true
    end

    context "when options are passed" do
      let(:options) { { foo: "baz" } }
      subject       { ShoeFactory.create(options) }

      it "overwrites the default attributes" do
        expect(subject.foo).to eq options[:foo]
      end
    end
  end

  describe "#build" do
    subject { ShoeFactory.build }

    context "when the resource does not implement .default_attributes" do
      before {
        expect(ShoeFactory).to receive(:default_attributes).and_raise(NoMethodError)
      }

      it "raises an error" do
        expect { subject }.to raise_error FactoryGuy::ImplementationError
      end
    end

    context "when options are passed" do
      let(:options) { { foo: "baz" } }
      subject       { ShoeFactory.build(options) }

      it "overwrites the default attributes" do
        expect(subject.foo).to eq options[:foo]
      end
    end

    context "when no options are passed" do
      it "initializes a new instance with the resource's default attributes" do
        expect(subject.foo).to eq ShoeFactory.default_attributes[:foo]
      end
    end
  end
end
