ActionMailer::Base.perform_deliveries = false
Faker::Config.locale = :fr

unless Rails.env.production?
  User.destroy_all
  Masterclass.destroy_all
  Recipe.destroy_all
  Meeting.destroy_all
  Reservation.destroy_all
  MasterclassesRecipe.destroy_all
end

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
  user.email = "#{user.first_name.parameterize}.#{user.last_name.parameterize}@yopmail.com"
  user.save
end

10.times do |_|
  user = User.new(first_name: Faker::Name.unique.first_name,
                  last_name: Faker::Name.unique.last_name,
                  password: 'foobar',
                  is_chef: true,
                  birth_date: Faker::Date.birthday(min_age: 18, max_age: 100),
                  phone_number: '0' + Faker::Number.number(digits: 9).to_s)
  user.email = "#{user.first_name.parameterize}.#{user.last_name.parameterize}@yopmail.com"
  user.save
end

User.chefs.each do |chef|
  2.times do |_|
    Recipe.create(title: Faker::Food.unique.dish,
                  content: Faker::Lorem.paragraph(sentence_count: 50),
                  duration: Faker::Number.within(range: 1..36) * 5,
                  difficulty: %w[facile moyen difficile].sample,
                  chef: chef)
  end

#   3.times do |_|
#     masterclass = Masterclass.new(title: Faker::Restaurant.unique.type,
#                                   description: Faker::Lorem.paragraph(sentence_count: 20),
#                                   duration: Faker::Number.within(range: 12..60) * 5,
#                                   price: Faker::Number.within(range: 1..100),
#                                   chef: chef)
#     masterclass.recipes << chef.taught_recipes.sample(rand(1..4))
#     masterclass.save
#   end
# end

# Masterclass.all.each do |masterclass|
#   rand(1..5).times do |_|
#     meeting = Meeting.new(masterclass: masterclass,
#                           start_date: Faker::Date.between(from: DateTime.now, to: 1.year.from_now),
#                           zip_code: Faker::Address.zip_code,
#                           capacity: Faker::Number.within(range: 1..10))
#     meeting.save
#   end
# end

# User.guests.each do |guest|
#   Masterclass.all.sample(rand(1..3)).each do |masterclass|
#     Reservation.create(guest: guest, meeting: masterclass.meetings.sample, status: false)
#   end
end
