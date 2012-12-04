describe "Dish", ->
	
	beforeEach ->
		@dish = new Dish "Masala Dosa $5.99 mains"

	it "extracts title", ->
		(expect @dish.title).toEqual "Masala Dosa"

	it "extracts price", ->
		(expect @dish.price.cents).toEqual 599

describe "Money", ->
	
	describe "valid value", ->
		
		beforeEach ->
			@money = new Money "$5.99"

		it "parses to cents", ->
			(expect @money.cents).toEqual 599
 
		it "formats to string", ->
			(expect @money.toString()).toEqual "$5.99"

	describe "invalid value", ->

		it "sets cents to zero if a money value can't be parsed", ->
			money = new Money "foo"
			(expect money.cents).toEqual 0
			(expect money.cents).toEqual 0

describe "Dish", ->

	beforeEach ->
		@idly = new Dish "Idly $2.99"
		@dosa = new Dish "Dosa $3.00"

	describe "blank object", ->

		beforeEach ->
			@meal = new Meal

		it "adds a single dish", ->
			@meal.add @idly
			(expect @meal.dishes.length).toEqual 1

		it "adds several dishes", ->
			@meal.add @idly, @dosa
			(expect @meal.dishes.length).toEqual 2

		it "calculates the total price", ->
			@meal.add @idly, @dosa
			(expect @meal.totalPrice().cents).toEqual 599