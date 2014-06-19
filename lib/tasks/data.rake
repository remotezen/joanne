require 'ffaker'
namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    make_users
    make_posts
    make_comments
    make_recipes
    make_steps
    make_toppings
  end
end

def make_users
  admin = Account.create!(name: 'Fred',
                        surname: 'Hudson',
                       user_name: 'bear',
                       email: 'grit@sdf.lonestar.org',
                       password: 'foobar',
                       password_confirmation: 'foobar',
                       role: 'admin')
  99.times do |n|
    name = Faker::Name.name
    surname = Faker::Name.last_name
    email = "example-#{n+1}@remotezen.ca"
    username = "#{Faker::Name.first_name}#{n}"
    password = 'password'
    role = 'user'
    Account.create!(name: name,
                 user_name: username,
                 surname: surname,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 role: role 
                 )
  end
end
def make_recipes
    main_ingredient = 'Fruit Vegetables Meat'
    course = 'main'
    prep_time = '30 minutes'
    cook_time = '1 hour and 15 minutes'
    image = 'bork.jpg'
    posts = Post.all
    posts.each do |post|
      content = 'cup of soup stock, whole apple, one pear, a peach, comma seperated values' 
      title = Faker::Lorem.sentence(5) 
      slug = title.gsub(' ','-')
     Recipe.create!( 
      content:content,
      main_ingredient:main_ingredient,
      title: title,
      course: course,
      image: image,
      prep_time: prep_time,
      cooking_time: cook_time,
      slug: slug,
      post_id: post.id)

    end
end
def make_toppings
  ingredients = '1 Tsp vinegar, 1 tsp tamari, 1cup of flour, handful of gogi berries'
  title = Faker::Lorem.sentence(7) 
  description = 'This is the way that you make your topping'
  recipes = Recipe.all
  recipes.each do |item|
  Topping.create!(
    title: title,
    description:description,
    ingredients:ingredients,
    recipe_id:item.id
  )

  end
end 
def make_steps
  recipes = Recipe.all
  image = 'bork.jpg'
  description = Faker::Lorem.sentence(30)
  recipes.each do |r|
    5.times do
      title = Faker::Lorem.sentence(5) 
      Step.create!(
        title: title,
        description: description,
        recipe_id: r.id,
        image: image
      )

    end

  end
end

def make_posts
  user_name = 'bear'
  account  = Account.where('user_name=?',user_name)
  image = 'bork.jpg'
  
  20.times do
    title = Faker::Lorem.sentence(6)
    body = Faker::Lorem.sentence(500)
    Post.create!(
      image: image,
      title: title,
      body: body,
      account_id: 1 
    )
  end
end

def make_comments
  posts = Post.all
  10.times do
    c = Faker::Lorem.sentence(5)
    posts.each{ |p| Comment.create!(comment:c,
                                    post_id:p.id)}
  end
end
=begin

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end
def make_logins
  users = User.all
  users.each{ |u| u.logins.create!(login_status:true) }
=end  

