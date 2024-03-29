class Recipe < ApplicationRecord
  include PgSearch::Model

  after_create :creator_becomes_chef

  belongs_to :chef, class_name: 'User'

  # Associations to find guests
  has_many :masterclasses_recipes
  has_many :masterclasses, through: :masterclasses_recipes
  has_many :meetings, through: :masterclasses
  has_many :reservations, through: :meetings
  has_many :guests, through: :reservations, class_name: 'User'

  has_one_attached :image

  validates :title, presence: { message: 'Le titre est obligatoire' },
                    format: { with: /\A[A-Za-z\-\s()&:'ÉÈéèêëôûüùïîàâäç]+\z/, message: 'Ne pas utiliser de caractères spéciaux' }, 
                    length: { in: 3..50, message: 'La taille doit être entre 3 et 50 caractères' }
  validates :content, presence: { message: 'Une description est obligatoire' },
                      length: { in: 100..100000, message: 'Il faut 100 caractères minimum' }
  validates :duration, presence: { message: 'Choisir une durée de 5 minutes minimum' },
                       numericality: { in: 5..300 }
  validate :duration_multiple_of_5
  validates :difficulty, presence: { message: 'Vous devez choisir le niveau de difficulté' },
                         inclusion: { in: %w[facile moyen difficile], message: "%<value>s n'est pas une difficulté valide" }

  pg_search_scope :search_by_description_and_title,
                  against: %i[content title],
                  using: { tsearch: { prefix: true } }
  def to_param
    title
  end

  def creator_becomes_chef
    return if chef.is_chef

    chef.is_chef = true
    chef.save!
    ChefMailer.new_chef_email(self).deliver_now
  end

  private

  def duration_multiple_of_5
    return unless duration.present? && (duration % 5) != 0

    errors.add(:duration, 'La durée doit être un multiple de 5 !')
  end
end
