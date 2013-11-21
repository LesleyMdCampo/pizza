require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'timecop'
require_relative '../pizza'

describe Pizza::Pie do

	describe '.initialize' do
		it 'records all of the toppings' do
			toppings = [
				Pizza::Topping.new('mushrooms', vegetarian: true),
				Pizza::Topping.new('pepperoni')
			]
			pizza = Pizza::Pie.new(toppings)

			expect(pizza.toppings).to eq(toppings)
		end

		it 'defaults the toppings to cheese only, if the pizza has no toppings' do
			pizza = Pizza::Pie.new

			expect(pizza.toppings.size).to eq(1)
			expect(pizza.toppings.first.name).to eq('cheese')
		end
	end

	describe '#deliver!' do
		it 'delivers the pizza in 30 minutes' do
			pizza = Pizza::Pie.new
			pizza.deliver!(now = Time.now)

			expect(pizza.delivery_time).should eq(now + 30*60)
		end
	end

	describe '#late?' do
		context 'The pizza is on time' do
			it 'returns false' do
				pizza = Pizza::Pie.new
				pizza.delivery_time = Time.now + 30

				expect(pizza.late?).to eq(false)
			end
		context 'The pizza is late' do
			it 'returns true' do
				pizza = Pizza::Pie.new
				pizza.delivery_time = Time.now - 30

				expect(pizza.late?).to eq(true)
			end
		end
	end

	describe '#vegetarian?' do
		it 'returns true if all the toppings are vegetarian' do
		pizza = Pizza::Pie.new
		
		expect(pizza.vegetarian?).to eq(true)
		end
	end

	describe '#add_topping' do
		it 'adds a topping to the toppings array' do
		toppings = [
				Pizza::Topping.new('mushrooms', vegetarian: true),
				Pizza::Topping.new('pepperoni')
			]
			pizza = Pizza::Pie.new(toppings)
			peppers = Pizza::Topping.new('peppers')
			pizza.add_topping(peppers)

			expect(pizza.toppings.length).to eq(3)
		end
	end	
end 

describe Pizza::Topping do
	describe '.initialize' do
		it "sets the name of the topping" do
			topping = Pizza::Topping.new('olives')

			expect(topping.name).to eq('olives')
		end
		it 'sets whether or not the topping is vegetarian' do
			topping = Pizza::Topping.new 'bell peppers', vegetarian: true

			expect(topping.vegetarian).to eq(true)
		end
	end
end