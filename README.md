Ruby project tempalte from [naliwajek/ruby-starter](https://github.com/naliwajek/ruby-starter)

# Commands

Build image

```
make build
```

Run tests, should be all green:

```
make test
```

To get into `ash` shell run:

```
make ash
```

And then to get into project console

```
bundle console
```

# Guided Tour

Also, look into `spec/acceptace` for automated version of this.

---

First, let's tie up all the pieces of our machine together:

```ruby
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
  change_gateway: change_gateway
)

# Machine
list_products_use_case = Machine::UseCase::ListProducts.new(
  product_gateway: product_gateway
)

check_funds_use_case = Machine::UseCase::CheckFunds.new(
  change_gateway: change_gateway,
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
# => Products loaded
```

## Buyer can now buy snacks

Let's list products in a format readable to humans, not developer i.e non-zero indexed:

```ruby
list_products_use_case.execute(
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

```ruby
insert_coin_use_case.execute(coin: '1gbp')
# => Inserted 1gbp coin
```

## Machine

Well, after each coin is inserted, poor machine will have to do the work of figuring out is this enough to give customer his selected product. 

```ruby
check_funds_use_case.execute
# => Waiting for 0.50
```

Client will eventually pay the rest

```ruby
insert_coin_use_case.execute(coin: '1gbp')
# => Inserted 1gbp coin
```

And machine will check the funds again, this time ready to release a product

```ruby
check_funds_use_case.execute
# => Releasing product...
# => Change: 0.50
```

And it will even release the change back to the customer.

## Q&A

**Q**: Where's this weird directory structure?

**A**: It's Clean Architecture. You can see several _actors_ in `lib/` directory. Use Cases are pretty abstract business units, asking concrete implementations for operating on data.


**Q**: Your domain objects, repositories and presenters are not tested!

**A**: They are implicitly tested by Use Cases and Gateways. Try changing them and see if it will break tests. Of course, it's weekend and I just want to go visit Kew Gardens but there's a chance there are no undetectable changes to be made.


**Q**: I don't like how you repeat initialisation of Use Cases everywhere.

**A**: I don't like it either. It breaks DIP (or D in SOLID) in quite uncontrolled ways and a bit of DI between Use Cases and Gateways is not helping to mitigate this 100%. IRL solution would be to use an inversion of control (IoC) container and create, for example, an Use Case Factory with a help of [dry-cotainer](https://github.com/dry-rb/dry-container) for example.


**Q**: Where's your delivery mechanism?

**A**: Since delivery mechanism like Rails MVC, HTTP REST API, RPC, (web)sockets, Microsoft Excel or whatever really is just an implementation detail, I didn't implement any. Codebase should be flexible enough to be put into any DM you may want.


**Q**: What if I want to move vending machine to different country?

**A**: Then you should introduce multiple different gateways. Probably one per country. Either way, current Use Cases will allow you to inject them willy-nilly as you wish.


**Q**: What if I want to send list of products to API?

**A**: Same as above. Introduce new presenter with the same interface (just `.present` method) and DI it.


**Q**: This project lacks...

**A**: Thousands of things. Rubocop being one of them. Docker should be `privileged: true` mode or if you run your CI/CD, like Jenkins or GitLab, itself in Docker, it will blow up. Factories mentioned in question above are another thing. There's also no mutation testing. And, well, repositories are plain old Ruby objects with class variables because I didn't want to spin up a whole new database container with Docker.


**Q**: How about...

**A**: I'm pretty sure there's more but it's weekend. I'm going to walk in the forest. Cheers.
