User.destroy_all
Masterclass.destroy_all
Recipe.destroy_all
Meeting.destroy_all
Reservation.destroy_all
MasterclassesRecipe.destroy_all

User.create(first_name: 'Didier',
            last_name: 'Guest',
            email: 'cookin_guest@yopmail.com',
            password: 'foobar',
            is_chef: false,
            birth_date: Faker::Date.birthday(min_age: 18, max_age: 100),
            phone_number: '0' + Faker::Number.number(digits: 9).to_s)

User.create(first_name: 'Alain',
            last_name: 'Chef',
            email: 'cookin_chef@yopmail.com',
            password: 'foobar',
            is_chef: true,
            birth_date: Faker::Date.birthday(min_age: 18, max_age: 100),
            phone_number: '0' + Faker::Number.number(digits: 9).to_s)

20.times do |_|
  user = User.new(first_name: Faker::Name.unique.first_name,
                  last_name: Faker::Name.unique.last_name,
                  password: 'foobar',
                  is_chef: false,
                  birth_date: Faker::Date.birthday(min_age: 18, max_age: 100),
                  phone_number: '0' + Faker::Number.number(digits: 9).to_s)
  user.email = "#{user.first_name}.#{user.last_name}@yopmail.com"
  user.save!
end

10.times do |_|
  user = User.new(first_name: Faker::Name.unique.first_name,
                  last_name: Faker::Name.unique.last_name,
                  password: 'foobar',
                  is_chef: true,
                  birth_date: Faker::Date.birthday(min_age: 18, max_age: 100),
                  phone_number: '0' + Faker::Number.number(digits: 9).to_s)
  user.email = "#{user.first_name}.#{user.last_name}@yopmail.com"
  user.save!
end

User.chefs.each do |chef|
  2.times do |_|
    Recipe.create!(title: Faker::Food.unique.dish,
                   content: Faker::Lorem.paragraph(sentence_count: 50),
                   duration: Faker::Number.within(range: 1..36) * 5,
                   difficulty: %w[facile moyen difficile].sample,
                   chef: chef)
  end

  3.times do |_|
    masterclass = Masterclass.new(title: Faker::Restaurant.unique.type,
                                  description: Faker::Lorem.paragraph(sentence_count: 20),
                                  duration: Faker::Number.within(range: 60..300),
                                  price: Faker::Number.within(range: 1..100),
                                  chef: chef)
    masterclass.recipes << chef.taught_recipes.sample(rand(1..4))
    puts masterclass.title
    masterclass.recipes.each { |recipe| puts recipe.title }
    masterclass.save!
  end
end

Meeting.create!(masterclass: Masterclass.first)
Reservation.create!(meeting: Meeting.first, guest: User.last)
