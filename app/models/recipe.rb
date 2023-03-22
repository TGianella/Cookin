class Recipe < ApplicationRecord
  belongs_to :chef, class_name: 'User'

  # Associations to find guests
  has_many :masterclasses_recipes
  has_many :masterclasses, through: :masterclasses_recipes
  has_many :meetings, through: :masterclasses
  has_many :reservations, through: :meetings
  has_many :guests, through: :reservations, class_name: 'User'

  private

  def to_param
    title.gsub(' ', '_').downcase
  end
end
