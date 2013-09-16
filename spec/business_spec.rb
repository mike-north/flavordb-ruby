require './spec_helper'

describe Flavordb::Business do

  before (:all) do
    @client = Flavordb::Client.new
  end

  before (:each) do
    @business = @client.get_business(142)
  end

  it "should know its resource" do
    @business.resource.should_not == nil
  end

  it "should know its name" do
    @business.name.should_not == nil
  end

  it "should know its id" do
    @business.id.should == 142
  end

  it "should retrieve its products on demand" do
    prods = @business.products
    prods.should_not == nil
  end

end
