window.Dish = class Dish
	constructor: (rawDescription = "") ->
		[all, @title, @price] = @parseRawDescription rawDescription
		@price = new Money @price

	parseRawDescription : (rawDescription) ->
		pattern = ///
			([^$]+) #title
			(\$\d+\.\d+) #price
		///
		result = rawDescription.match pattern
		r.trim() for r in result

	toJSON : ->
		title : @title
		price : @price.toString()

window.Money = class Money
	constructor : (rawString = "") ->
		@cents = @parseRawString rawString

	parseRawString : (rawString) ->
		[dollers, cents] = (rawString.match /(\d+)/g) ? [0, 0]
		+cents + (dollers*100)

	toString : ->
		"$#{Math.floor(@cents / 100)}.#{@cents % 100}"

window.Meal = class Meal
	constructor : ->
		@dishes = []
	add : (dishes...) ->
		@dishes.push dishes...
	totalPrice : ->
		total = new Money
		total.cents = total.cents + dish.price.cents for dish in @dishes
		total
	toJSON : ->
		total : @totalPrice().toString()
		dishes : dish.toJSON() for dish in @dishes
