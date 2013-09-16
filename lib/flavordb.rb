require 'flavordb/version'
require 'flavordb/client'

module Flavordb

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :verbose

    def initialize
      @verbose = true
    end
  end
end
