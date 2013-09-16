require 'flavordb/base'

module Flavordb
  class ProductCategory < Base
    attr_reader :parent_category_id

    class << self
      def object_cache
        @object_cache = {} if @object_cache.nil?
        @object_cache
      end
    end

    def initialize data
      super
      @is_root = data['rootCategory'] || false
      @parent_category_id = data['parentCategoryId']
      @products_resource = data['productsResource']
      @subcategories_resource = data['subcategoriesResource']
    end

    def root?
      @is_root
    end

    def parent_category(opts = {})
      client = opts[:client] || Flavordb::Client.default_client
      client.get_product_category(parent_category_id)
    end

    def products(opts = {})
      client = opts[:client] || Flavordb::Client.default_client
      product_data = client.get_object_data_by_path "#{self.resource}/products"
      product_data['data'].map {|p| Flavordb::Product.get_or_create p}
    end

    def subcategories(opts = {})
      client = opts[:client] || Flavordb::Client.default_client
      subcategory_data = client.get_object_data_by_path "#{self.resource}/subcategories"
      subcategory_data['data'].map {|sc| Flavordb::ProductCategory.get_or_create sc}
    end
  end
end