require './spec_helper'

describe Flavordb::ProductCategory do

  before (:all) do
    @client = Flavordb::Client.new
  end

  before (:each) do
    @product_category = @client.get_product_category(16)
  end

  it "@product_category know its resource" do
    @product_category.resource.should_not == nil
  end

  it "should know its name" do
    @product_category.name.should_not == nil
  end

  it "should know its id" do
    @product_category.id.should == 16
  end

  it "should know whether it's a root category" do
    @product_category.root?.should == false
  end

  it "should have a parent_category_id property" do
    @product_category.parent_category_id.should_not == nil
  end

  it "should load parent category upon request" do
    parent_category = @product_category.parent_category
    parent_category.should_not == nil
    parent_category.id.should == @product_category.parent_category_id
  end

  it "should load subcategories upon request" do
    subcategories = @product_category.subcategories
    subcategories.should_not == nil
    subcategories[0].parent_category_id.should == @product_category.id
  end

  it "should load products upon request" do
    products = @product_category.products
    products.should_not == nil
  end
end
