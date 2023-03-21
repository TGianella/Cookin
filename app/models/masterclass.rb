class Masterclass < ApplicationRecord
  belongs_to :chef, class_name: "User"
  has_many :masterclasses_recipes
  has_many :recipes, through: :masterclasses_recipes

  # Associations as attended masterclass
  has_many :meetings
  has_many :reservations, through: :meetings
  has_many :guests, through: :reservations, class_name: "User"

end
