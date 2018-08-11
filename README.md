# Commands

See in Makefile.

# Guided Tour

First, let's tie up all the pieces together:

```ruby
require_all 'lib'

change_gateway = Machine::Gateway::Change.new
product_gateway = Machine::Gateway::Product.new

# Staff actor
load_change_use_case = Staff::UseCase::LoadChange.new(
  change_gateway: change_gateway
)
load_products_use_case = Staff::UseCase::LoadProducts.new(
  product_gateway: product_gateway
)
```

Now let's load some change money into a machine:

```ruby
change_array = %w(1gbp 1gbp 1gbp 2gbp 50p 50p 50p 50p 20p 20p 20p 10p 10p 5p 1p 1p 1p 1p 1p)

load_change_use_case.execute(change_array: change_array)
# => Change loaded
```

We should also load some products:

```ruby
products = [ { name: 'Mars', price: 1.50 }, { name: 'Milkway', price: 1.0 }]

load_products_use_case.execute(products: products)
```