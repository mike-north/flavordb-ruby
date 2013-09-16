require 'spec/spec_helper'

describe Flavordb::Product do

  before (:all) do
    @client = Flavordb::Client.new
  end

  before (:each) do
    @product = @client.get_product(1234)
  end

  it "@product_category know its resource" do
    @product.resource.should_not == nil
  end

  it "should know its name" do
    @product.name.should_not == nil
  end

  it "should know its id" do
    @product.id.should == 1234
  end

  it "should retrieve its business on demand" do
    business = @product.business
    business.should_not == nil
  end

  it "should retrieve its product category on demand" do
    product_category = @product.product_category
    product_category.should_not == nil
  end
end
