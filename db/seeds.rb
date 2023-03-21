User.destroy_all
Masterclass.destroy_all
Recipe.destroy_all
Meeting.destroy_all
Reservation.destroy_all
MasterclassesRecipe.destroy_all


User.create!(password: "foobar", email: "test@test.test")
User.create!(password: "foobar", email: "test@test.fr")

Recipe.create!(chef: User.first)
masterclass = Masterclass.create!(chef: User.first)
masterclass.recipes << Recipe.first
Meeting.create!(masterclass: Masterclass.first)
Reservation.create!(meeting: Meeting.first, guest: User.last)





