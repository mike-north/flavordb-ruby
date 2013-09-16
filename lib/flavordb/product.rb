require 'flavordb/base'

module Flavordb
  class Product < Base
    attr_reader :product_category_id, :business_id
    class << self
      def object_cache
        @object_cache = {} if @object_cache.nil?
        @object_cache
      end
    end

    def business(opts={})
      client = opts[:client] || Flavordb::Client.default_client
      client.get_business(business_id)
    end

    def product_category(opts={})
      client = opts[:client] || Flavordb::Client.default_client
      client.get_product_category(product_category_id)
    end

    protected
    def initialize data
      super
      @product_category_id = data['productCategoryId']
      @business_id = data['businessId']
      @business_resource = data['business'] ? data['business']['resource'] : nil
      @product_category_resource = data['productCategory'] ? data['productCategory']['resource'] : nil
    end
  end
end