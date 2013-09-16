require 'flavordb/version'
require 'flavordb/client'

module Flavordb

  class << self
    attr_accessor :configuration

    def configuration
      if @configuration.nil?
        @configuration = Configuration.new
      end
      @configuration
    end

    def configure
      @configuration ||= Configuration.new
      yield(@configuration)
    end

  end



  class Configuration
    attr_accessor :verbose

    def initialize
      @verbose = true
    end
  end
end
