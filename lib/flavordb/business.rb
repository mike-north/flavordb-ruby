require 'flavordb/base'

module Flavordb
  class Business < Base

    class << self
      def object_cache
        @object_cache = {} if @object_cache.nil?
        @object_cache
      end
    end

    def products(opts = {})
      client = opts[:client] || Flavordb::Client.default_client
      product_data = client.get_object_data_by_path "#{self.resource}/products"
      product_data['data'].map {|p| Flavordb::Product.get_or_create p}
    end

    protected
    def initialize data
      super
      @products_resource = data['productsResource']
    end


  end
end