require 'flavordb/version'
require 'typhoeus'
require 'json'

require 'flavordb/business'
require 'flavordb/product_category'
require 'flavordb/product'

module Flavordb

  class Client

    attr_reader :api_endpoint, :api_key, :api_secret

    class << self
      attr_accessor :default_client
      def initialize
        @default_client = nil
      end
    end


    def initialize(key = ENV['FLAVORDB_API_KEY'], secret = ENV['FLAVORDB_API_SECRET'], opts = {})
      @api_endpoint = opts[:api_endpoint] || default_api_endpoint
      @api_key = key
      @api_secret = secret
      self.class.default_client = self #if self.class.default_client.nil?
    end

    def valid?
      if api_key.nil? || api_secret.nil?
        return false
      else
        !get_oauth_token.nil?
      end
    end

    def find_businesses(params)
      raw_businesses = get_object_data_by_path "/businesses", params
      if !raw_businesses['data'].nil?
        raw_businesses['data'].map {|b| Business.get_or_create(b)}
      else
        nil
      end
    end

    def find_products(params)
      raw_products= get_object_data_by_path "/products", params
      if !raw_products['data'].nil?
        raw_products['data'].map {|b| Product.get_or_create(b)}
      else
        nil
      end
    end

    def get_business(id)
      raw_business = get_object_data_by_path("/businesses/#{id}")
      !raw_business['data'].nil? ? Business.get_or_create(raw_business['data']) : nil
    end

    def get_product_category(id)
      raw_category = get_object_data_by_path("/product_categories/#{id}")
      !raw_category['data'].nil? ? ProductCategory.get_or_create(raw_category['data']) : nil
    end

    def get_product(id)
      raw_product = get_object_data_by_path("/products/#{id}")
      !raw_product['data'].nil? ? Product.get_or_create(raw_product['data']) : nil
    end

    def get_object_data_by_path (path, api_params={})
      url = (path =~ /http:\/{2}/).nil? ? "#{api_endpoint}#{path}" : path
      authenticated_json_request :get, url, api_params
    end

    def api_token
      if @api_token.nil?
        @api_token = get_oauth_token
      end
      @api_token
    end

    private
    def authenticated_json_request (method, url, api_params)
      request = Typhoeus::Request.new url,
                                      :method => method,
                                      :headers => { 'Authorization' => "Bearer #{api_token}" },
                                      :params => api_params

      if Flavordb.configuration.verbose
        request_url = request.url
        request_url = "#{request_url}#{(request_url =~ /\?/).nil? ? '?' : '&'}access_token=#{api_token}"
        puts "[Flavordb API]: #{request_url}"
      end

      response = request.run
      if response.return_code == :ok
        response_data = JSON.parse response.body
        response_data
      else
        raise "Bad request: #{url}\n\tSTATUS: #{response.return_code}\n\tMESSAGE: #{response.return_message}"
      end
    end

    def get_oauth_token
      server_response = Typhoeus.post 'http://www.flavordb.com/oauth/token', :params => {
          :grant_type => 'client_credentials',
          :client_id => api_key,
          :client_secret => api_secret
      }
      begin
        response_data = JSON.parse(server_response.body)
        tok = response_data['access_token']
        if !tok.nil?
          @api_token = tok
          @api_token
        else
          nil
        end
      rescue Exception => e
        puts "ERROR: #{e.message}"
        nil
      end
    end


    def default_api_endpoint
      'http://api.flavordb.com/api/v1'
    end
  end
end
