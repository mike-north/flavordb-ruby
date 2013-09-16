[![build status](https://api.travis-ci.org/TrueNorth/flavordb-ruby.png)](https://travis-ci.org/TrueNorth/flavordb-ruby)
# Flavordb

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'flavordb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flavordb

## Usage

### API Credentials
It's best to store your API credentials as environment variables

./config/initializers/flavordb.rb
```ruby
ENV['FLAVORDB_API_KEY'] = '93a5da2ed....'
ENV['FLAVORDB_API_SECRET'] = '7ff85916b58f...'
```

### Working with the data
```ruby
# Create an instance of the API client
client = Flavordb::Client.new

# get a product category by id
product_category = client.get_product_category(1)
# subcategories
product_category.subcategories.each do |subcategory|
    puts subcategory.name
end
# parent category
parent_category = product_category.parent_category
# products
product_array = product_category.products


# get a product by id
product = client.get_product(1234)

# get a business by id
business = client.get_business(150)
# products
business_products = business.products


```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

(The MIT License.)

© 2009–2013 Michael North

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
