class Recipe < ApplicationRecord
  belongs_to :chef, class_name: 'User'

  # Associations to find guests
  has_many :masterclasses_recipes
  has_many :masterclasses, through: :masterclasses_recipes
  has_many :meetings, through: :masterclasses
  has_many :reservations, through: :meetings
  has_many :guests, through: :reservations, class_name: 'User'

  validate :owner_is_chef
  validates :title, presence: true,
                    format: { with: /\A[A-Za-z\-\s']+\z/ },
                    length: { in: 3..50 }
  validates :content, presence: true,
                      length: { minimum: 100 }
  validates :duration, presence: true,
                       numericality: { in: 5..180 }
  validate :duration_multiple_of_5
  validates :difficulty, presence: true,
                         inclusion: { in: %w[facile moyen difficile], message: "%<value>s n'est pas une difficulté valide" }

  def to_param
    title
  end

  private

  def duration_multiple_of_5
    return unless duration.present? && (duration % 5) != 0

    errors.add(:duration, 'La durée doit être un multiple de 5 !')
  end

  def owner_is_chef
    return unless chef.present? && !chef.is_chef

    errors.add(:chef, 'Le propriétaire de la recette doit être chef !')
  end
end
