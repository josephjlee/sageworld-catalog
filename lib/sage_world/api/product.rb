# Summary
  # Sage world product api provides you 2 basic operations for
  # => search -> returns collection of searched products.
  # => details -> return details of product.

module SageWorld
  module Api
    class Product < SageWorld::Api::Base

      DEFAULT_SEARCH_PARAMS = {
        quick_search: ''
      }.freeze

      def initialize(product_id)
        @product_id = product_id
      end

      # Product Details
      # Usage:
      # product = SageWorld::Api::Product.new("Product_id_or_spc")
      # response = product.details
      # response.as_hash => product details as hash
      # response.as_xml => product details as xml

      def details(options = {})
        if @existing_options == options
          @response
        else
          @existing_options = options
          response = SageWorld::Client.new(find_product_params(@product_id ,options)).send_request
          @response = SageWorld::ResponseHandler.new(response)
        end
      end

      # Search
      #
      # Usage:
      #
      # Keyword for searching is necessary.
      #
      # response = SageWorld::Api::Product.search("mug", { })
      # response.as_xml => returns xml response.
      # response.as_hash => returns hash response.

      # Searching Options
      # Basic searching can be combined with multiple options available to narrow down the searching scope.
      # Following are the options that can be used along with searching.
      #

      # Categories => string
        # by category name
          # e.g response = SageWorld::Api::Product.search("Ceramic mug", { categories: "Mugs" })

        # by category number
          # e.g response = SageWorld::Api::Product.search("Ceramic mug", { categories: "232" })

      # Keywords => string
        # Every product has some product keywords. searching can be narrowed down using keywords
        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { categories: "Mugs", keywords: "Tshirt" })

      # Themes => string
        # Every product has some product theme associated to it.
        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { categories: "Mugs", themes: "Household" })

      # SPC => string
        # Search by SPC
        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { categories: "Mugs", themes: "Household", spc: "ISUP-SJKHS" })

      # ItemNum => string
       # Search by ItemNum
       # e.g response = SageWorld::Api::Product.search("Ceramic mug", { categories: "Mugs", themes: "Household", item_num: "5000" })

      # ItemName => string
        # Search by ItemName
        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug" })

      # PriceLow => currency
        # Search by Lowest Price in USD ( US dollars )
        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", price_low: 2 })

      # PriceHigh => currency
        # Search by Highest Price in USD ( US dollars )
        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", price_high: 2 })

      # Qty => integer
        # Search by Quantity
        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", qty: 2 })

      # Verified => bool
        # whether product is verified
        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", verified: true })

      # Recyclable => 0 or 1
        # whether product is recyclable
        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", recyclable: 0 })

      # EnvFriendly => 0 or 1
        # whether product is Environment Friendly
        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", env_friendly: 1 })

      # NewProduct => 0 or 1
        # whether product is a new product
        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", new_product: 1 })

      # UnionShop => 0 or 1
        # whether product is a new product
        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", union_shop: 1 })

      # ProdTime => integer
        # Minimumproduction timein working days or '0' forany
        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", prod_time: 1 })

      # MadeIn => string
        # Countrymadein. Blankforall or two-digitcountrycode
        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", made_in: "us" })

      # LineName => string
        # Specific Supplier'sLine Name
        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", line_name: "Sunset Hill Stoneware" })

      # Sort => "Blank", "PRICE", "PRICEHIGHLOW", "BESTMATCH", "POPULARITY", "PREFGROUPS"
       # Blank: Indicates thatthe defaultsortwill be used (as specified in WebStore Settings)
       # PRICE: Pricesortingin lowestto highest order.
       # PRICEHIGHLOW: Pricesortingin highestto lowest order.
       # BESTMATCH: Sort bythe bestmatch based on thecriteria.
       # POPULARITY: Sorttheitems in terms of popularity, with most popular first.
       # PREFGROUP: Sort by preferencegroups.

       # e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", sort: "PRICE" })

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

        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", extra_return_fields: "description, themes, prodtime" })

      # StartNum => integer && MaxRecs => integer
        # Record number to startwith (1=FIRST) &  MaxRecs => Maxrecords to return per page

        # The StartNumand MaxRecs fieldsare used to return asubset of thetotalsearch results. Thisallowsyou to implement“records
        # per page”functionality. Ifyou do notwish to usethesefields, leave both empty. However, ifyou do wantto usethis functionality,
        # the StartNumshould contain thestartingrecord number for this requestand the MaxRecs should contain the number of records
        # to return.Forexample, ifasearch returns110total productsand you would liketo displayrecords1-20,you would enter “1”for
        # StartNumand “20”for MaxRecs. Then, to showrecords21-40,enter “21”as the StartNumand “20”again for MaxRecs.

        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", start_num: 1, max_recs: 20 })

      # MaxTotalItems => integer
        # Maxitems to find (<=1000)
        # e.g response = SageWorld::Api::Product.search("Ceramic mug", { pr_name: "13 Ceramic Mug", max_total_items: 100 })

      def self.search(keyword, options = {})
        options[:quick_search] = keyword
        params = DEFAULT_SEARCH_PARAMS.merge(options)
        response = SageWorld::Client.new(search_product_params(params)).send_request
        SageWorld::ResponseHandler.new(response)
      end

      private def find_product_params(product_id, options)
        {
          product_detail: {
            product_id: product_id
          }
        }.merge(options)
      end

      private_class_method def self.search_product_params(params)
        {
          search: params
        }
      end

    end
  end
end
