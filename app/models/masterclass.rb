class Masterclass < ApplicationRecord
  include PgSearch::Model

  belongs_to :chef, class_name: 'User'
  has_many :masterclasses_recipes
  has_many :recipes, through: :masterclasses_recipes

  # Associations as attended masterclass
  has_many :meetings, dependent: :destroy
  has_many :reservations, through: :meetings
  has_many :guests, through: :reservations, class_name: 'User'

  has_one_attached :image

  validate :owner_is_chef
  validates :title, presence: true,
                    format: { with: /\A[A-Za-z\-\s'()&]+\z/ },
                    length: { in: 3..50 }
  validates :description, presence: true,
                          length: { in: 100..100_000 }
  validates :duration, presence: true,
                       numericality: { in: 60..300 }
  validate :duration_multiple_of_5
  validates :price, presence: true,
                    numericality: { in: 1..1000 }
  validate :recipes_belong_to_same_chef
  validates :recipes, presence: true

  pg_search_scope :search_by_description_and_title,
                  against: %i[description title],
                  using: { tsearch: { prefix: true } }

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

  def recipes_belong_to_same_chef
    return unless recipes.present? && recipes.any? { |recipe| recipe.chef != chef }

    errors.add(:recipes, 'Les recettes doivent être du même chef que la masterclass !')
  end
end
