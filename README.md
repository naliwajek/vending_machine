# Commands

See in Makefile.

# Guided Tour

First, let's tie up all the pieces together:

```ruby
require_all 'lib'

change_gateway = Machine::Gateway::Change.new
product_gateway = Machine::Gateway::Product.new

products_presenter_for_humans = Buyer::Presenter::Products.new

# Staff actor
load_change_use_case = Staff::UseCase::LoadChange.new(
  change_gateway: change_gateway
)
load_products_use_case = Staff::UseCase::LoadProducts.new(
  product_gateway: product_gateway
)

# Buyer
select_product_use_case = Buyer::UseCase::SelectProduct.new(
  product_gateway: product_gateway
)

insert_coin_use_case = Buyer::UseCase::InsertCoin.new(
  product_gateway: product_gateway
)

# Machine
list_products_use_case = Machine::UseCase::ListProducts.new(
  product_gateway: product_gateway
)
```

## Staff needs to setup machine

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

## Buyer can now buy snacks

Let's list products in a format readable to humans, not developer i.e non-zero indexed:

```ruby
list_products_use_cae.execute(
  presenter: products_presenter_for_humans
)
# => Select number to choose product
# => [1] Mars for only 1.50!
# => [2] Milkway for only 1.00!
```

As a buyer I can now select a product:

```ruby
select_product_use_case.execute(selected_product_id: 3)
# => Machine::Errors::NoSuchProduct raised!
```

Oops, we have only two products, stupid us. Let's fix it.

```ruby
select_product_use_case.execute(selected_product_id: 1)
# => Product selected
```

We can now pay our 1.50 for Mars:

```ruby
insert_coin_use_case.execute(coin: '2eur')
# => Machine::Errors::InvalidCoin
```

Woah, not that fast. We ain't accepting continental money!

```
insert_coin_use_case.execute(coin: '1gbp')
# => Inserted 1gbp coin
```