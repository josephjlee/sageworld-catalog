# SageWorld

SageWorld provides an easier way to use sageworld api using ruby.
https://www.sageworld.com/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sage_world', '~> 0.1.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sage_world

  ### #Installation
  Run `rails g sage_world:install` to generate sage_world initializer file.
  This will generate `config/initializer/sage_world_initializer.rb` which contains the following code.
  ```ruby
    SageWorld.config do |config|
        # Sage Account ID
        config.account_id = ENV['sage_api_account']
        # Sage Login
        config.login = ENV['sage_api_login']
        # Sage Password
        config.password = ENV['sage_api_password']
        # Sage Api Version
        config.version = ENV['sage_api_version']
        # Sage End Point
        config.end_point = ENV['sage_api_end_point']
        # Optional Logging
        config.log_data = true # logs request response to log/sage_world.log
     end
  ```

### #Usage
SageWorld provides operations on following entities.
- Category List - Available product categories.
- Suppliers List - Available suppliers.
- Supplier Details - Supplier details.
- Products Search - Search product
- Product Details - Product details
- Product Theme List - Available Product themes

### Category List
```ruby
response = SageWorld::Api::CategoryList.get
# default result is sorted by name.
# Sorting Results

## Sort-By name
response = SageWorld::Api::CategoryList.get({ sort: "name"})

## Sort-By category number
response = SageWorld::Api::CategoryList.get({ sort: "catnum"})
```

### Supplier List

```ruby
response = SageWorld::Api::SupplierList.get
# default result is sorted by name.
# Sorting Results
# Supplier list can be sorted by sageid, company or line

## Sort-By sage_id
response = SageWorld::Api::SupplierList.get({ sort: "sageid" })

## Sort-By company
response = SageWorld::Api::SupplierList.get({ sort: "company" })

# Sort-By line
response = SageWorld::Api::SupplierList.get({ sort: "line" })

# AllLines => if set to 1 will return AllLines with every supplier
response = SageWorld::Api::SupplierList.get({ alllines: 1 })
```

### Supplier Details

```ruby
supplier = SageWorld::Api::Supplier.new(supplier_id)
response = supplier.details
response.body => { product_details: { ..} }

# Options

# ExtraReturnFields => specifies additional fields to be returned. If you would like to return the general information for a supplier, then include GENINFO in this field. Otherwise leave it blank.

supplier = SageWorld::Api::Supplier.new("22")
e.g response = supplier.details({ extra_return_fields: "geninfo" })
```


### Product Search

```ruby
# Keyword for searching is mandatory.
#
response = SageWorld::Api::Product.search("mug", { })
response.body #=> returns hash response.

# Searching Options
# Basic searching can be combined with multiple options available to narrow down the searching scope.
# Following are the options that can be used along with searching.


# Categories => string
    # by category name
    response = SageWorld::Api::Product.search("Ceramic mug", { categories: "Mugs" })

    # by category number
    response = SageWorld::Api::Product.search("Ceramic mug", { categories: "232" })

# Keywords => string
    # Every product has some product keywords. searching can be narrowed down using keywords
    response = SageWorld::Api::Product.search("Ceramic mug", { categories: "Mugs", keywords: "Tshirt" })


# Themes => string
    # Every product has some product theme associated to it.
    response = SageWorld::Api::Product.search("Ceramic mug", { categories: "Mugs", themes: "Household" })


# SPC => string
    # Search by SPC
    response = SageWorld::Api::Product.search("Ceramic mug", { categories: "Mugs", themes: "Household", spc: "ISUP-SJKHS" })

  # ItemNum => string
   # Search by ItemNum
   response = SageWorld::Api::Product.search("Ceramic mug", { categories: "Mugs", themes: "Household", item_num: "5000" })

  # ItemName => string
    # Search by ItemName
    response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug" })

  # PriceLow => currency
    # Search by Lowest Price in USD ( US dollars )
   response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", price_low: 2 })

  # PriceHigh => currency
    # Search by Highest Price in USD ( US dollars )
    response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", price_high: 2 })

  # Qty => integer
    # Search by Quantity
    response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", qty: 2 })

  # Verified => bool
    # whether product is verified
    response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", verified: true })

  # Recyclable => 0 or 1
    # whether product is recyclable
    response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", recyclable: 0 })

  # EnvFriendly => 0 or 1
    # whether product is Environment Friendly
    response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", env_friendly: 1 })

  # NewProduct => 0 or 1
    # whether product is a new product
    response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", new_product: 1 })

  # UnionShop => 0 or 1
    # whether product is a new product
    response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", union_shop: 1 })

  # ProdTime => integer
    # Minimumproduction timein working days or '0' forany
    response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", prod_time: 1 })

  # MadeIn => string
    # Countrymadein. Blankforall or two-digitcountrycode
    response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", made_in: "us" })

  # LineName => string
    # Specific Supplier'sLine Name
    response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", line_name: "Sunset Hill Stoneware" })

  # Sort => "Blank", "PRICE", "PRICEHIGHLOW", "BESTMATCH", "POPULARITY", "PREFGROUPS"
   # Blank: Indicates thatthe defaultsortwill be used (as specified in WebStore Settings)
   # PRICE: Pricesortingin lowestto highest order.
   # PRICEHIGHLOW: Pricesortingin highestto lowest order.
   # BESTMATCH: Sort bythe bestmatch based on thecriteria.
   # POPULARITY: Sorttheitems in terms of popularity, with most popular first.
   # PREFGROUP: Sort by preferencegroups.

   response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", sort: "PRICE" })

  # ExtraReturnFields => Comma separated fields name
   # Return additional fields in theresponsestring

   # Can be from the following :
     # "itemnum" - will return the product’s actual item number.
     # "category" - will return the productcategory name.
     # "description" - will return the description for the item.
     # "colors" - will return thecolor options for the item.
     # "themes" - will return the themes for the item.
     # "netprices" - will return theextended price information, including net pricing, published (catalog) pricing and published.
     # "suppid" - will return the supplier’s Sage.
     # "line" - will return the line name.
     # "company" - will return the company name of the supplier.
     # "prodtime" - will return the production timefor the item.

    e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", extra_return_fields: "description, themes, prodtime" })

  # StartNum => integer && MaxRecs => integer
    # Record number to startwith (1=FIRST) &  MaxRecs => Maxrecords to return per page

    # The StartNumand MaxRecs fieldsare used to return asubset of thetotalsearch results. Thisallowsyou to implement“records
    # per page”functionality. Ifyou do notwish to usethesefields, leave both empty. However, ifyou do wantto usethis functionality,
    # the StartNumshould contain thestartingrecord number for this requestand the MaxRecs should contain the number of records
    # to return.Forexample, ifasearch returns110total productsand you would liketo displayrecords1-20,you would enter “1”for
    # StartNumand “20”for MaxRecs. Then, to showrecords21-40,enter “21”as the StartNumand “20”again for MaxRecs.

    response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", start_num: 1, max_recs: 20 })

  # MaxTotalItems => integer
    # Maxitems to find (<=1000)
    response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", max_total_items: 100 })
```

### Product Details

```ruby
    product = SageWorld::Api::Product.new("Product_id_or_spc")
    response = product.details
    response.body # => returns hash having details of product.
```

### Product Theme List

```ruby
 # Get Product theme list.
response = SageWorld::Api::ProductThemeList.get # => return SageWorld::ResponseHandler object.
response.body #=> { .. }
```

### Hash details finder
The api response is going to be hash which can be accessed directly via using hash[:key] or for every key that is defined there is a method defined on `response` object which makes it easier to get to nested field.
```ruby
For Example:
response # =>
{
 Response: {
   "CategoryList": {
       "Category": ['category 1', 'category2']
   }
 }
}

response.category #=> ['category 1', 'category2']
response.category_list #=>
# {
#   "Category": ['category 1', 'category2']
#  }
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vinsol/sageworld-catalog. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
