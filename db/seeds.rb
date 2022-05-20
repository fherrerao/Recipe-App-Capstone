# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.destroy_all
first_user = User.new(name: 'Billy', email: 'first@email.com', :password => '123456', :password_confirmation => '123456')
first_user.skip_confirmation!
first_user.save!
second_user = User.new(name: 'Bob', email: 'second@email.com', :password => '123456', :password_confirmation => '123456')
second_user.skip_confirmation!
second_user.save!

first_food = Food.create!(name: 'Rice', measurement_unit: 'grams', price: 1.2, user: first_user)
second_food = Food.create!(name: 'Beans', measurement_unit: 'grams', price: 2.3, user: first_user)
third_food = Food.create!(name: 'Oil', measurement_unit: 'millilitters', price: 0.6, user: first_user)

fourth_food = Food.create!(name: 'Spaghetti', measurement_unit: 'grams', price: 2.3, user: second_user)
fifth_food = Food.create!(name: 'Tomato', measurement_unit: 'grams', price: 1.1, user: second_user)
sixth_food = Food.create!(name: 'Pesto', measurement_unit: 'grams', price: 4.2, user: second_user)

first_recipe = Recipe.create!(name: 'Gallo Pinto', preparation_time: 4.5, cooking_time: 8, description: 'Traditional costarrican dish', public: true, user: first_user)
second_recipe = Recipe.create!(name: 'Empanadas', preparation_time: 12, cooking_time: 25, description: 'Traditional latin dish', public: false, user: first_user)

third_recipe = Recipe.create!(name: 'Spaghetti al Pomodoro', preparation_time: 7, cooking_time: 14, description: 'Traditional roman dish', public: true, user: second_user)
fourth_recipe = Recipe.create!(name: 'Spaghetti al Pesto', preparation_time: 9, cooking_time: 17, description: 'Traditional italian dish', public: false, user: second_user)
fifth_recipe = Recipe.create!(name: 'Spaghetti and Tomato', preparation_time: 8, cooking_time: 22, 
  description: "1. Heat 2 tsp oil in a medium saucepan over a medium heat and fry the breadcrumbs for 3-4 mins, stirring often, until just turning golden brown. Add half the garlic and a pinch of thyme, then cook for another 1 min until toasted and fragrant. Tip into a bowl and set aside.\n2. Add the remaining 2 tsp oil to the pan and cook the onion over a medium heat for 5-6 mins until softened and slightly browning. Add the remaining garlic and ½ tsp thyme, cook for 1 min, then add the pinch of thyme, the tomatoes and vinegar; season. Stir well and bring to a simmer.\n3. Break the spaghetti in half and add to the pan with 500ml boiling water. Cook over a medium heat for 10-12 mins until the pasta is al dente, adding a splash more water if it starts to stick. Divide between 2 bowls and scatter over the garlicky breadcrumbs to serve.", 
  public: true, user: first_user)

first_recipe_food = RecipeFood.create!(quantity: 2.1, recipe: first_recipe, food: first_food)
second_recipe_food = RecipeFood.create!(quantity: 5.1, recipe: first_recipe, food: second_food)
third_recipe_food = RecipeFood.create!(quantity: 5.1, recipe: second_recipe, food: second_food)
fourth_recipe_food = RecipeFood.create!(quantity: 8, recipe: fifth_recipe, food: fourth_food)
fifth_recipe_food = RecipeFood.create!(quantity: 8, recipe: fifth_recipe, food: fifth_food)
