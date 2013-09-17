
require 'spec_helper'

describe Flavordb::Client do

  it "should use the API endpoint passed to it" do
    client = Flavordb::Client.new(nil, nil, :api_endpoint => 'http://localhost:12345')
    client.api_endpoint.should == 'http://localhost:12345'
  end

  it "should use API credentials from environment variables" do
    ENV['FLAVORDB_API_KEY'].should_not == nil?
    ENV['FLAVORDB_API_SECRET'].should_not == nil?
    client = Flavordb::Client.new
    client.api_key.should == ENV['FLAVORDB_API_KEY']
    client.api_secret.should == ENV['FLAVORDB_API_SECRET']
  end

  it "should know it's invalid if initialized with invalid API credentials" do
    client = Flavordb::Client.new(nil, nil)
    client.valid?.should == false
  end
  it "should know it's valid if initialized with valid API credentials" do
    client = Flavordb::Client.new
    client.valid?.should == true
  end

  it "should be able to request an object by path" do
    client = Flavordb::Client.new
    business = client.get_object_data_by_path('/businesses/16')
    business.should_not == nil
    business['data']['id'].should == 16
  end

  it "should be able to get a business by id" do
    client = Flavordb::Client.new
    business = client.get_business(16)
    business.should_not == nil
    business.id.should == 16
  end

  it "should be able to find businesses by name" do
    client = Flavordb::Client.new
    businesses = client.find_businesses(:q => 'Lagunitas')
    businesses.should_not == nil
  end

  it "should be able to get a product category by id" do
    client = Flavordb::Client.new
    product_category = client.get_product_category(16)
    product_category.should_not == nil
    product_category.id.should == 16
  end

  it "should be able to get a product by id" do
    client = Flavordb::Client.new
    product = client.get_product(16)
    product.should_not == nil
    product.id.should == 16
  end

end
