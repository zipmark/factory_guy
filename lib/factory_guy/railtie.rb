module FactoryGuy
  class Railtie < Rails::Railtie
    initializer "my_railtie.configure_rails_initialization" do

      # load in all factories
      Dir[Rails.root.join("spec/factories/**/*_factory.rb")].each { |f| require f }

    end
  end
end
