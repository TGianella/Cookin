class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations as chef
  has_many :given_masterclasses, class_name: 'Masterclass', foreign_key: :chef_id
  has_many :taught_recipes, class_name: 'Recipe', foreign_key: :chef_id

  # Associations as guest
  has_many :reservations, foreign_key: :guest_id
  has_many :meetings, through: :reservations
  has_many :attended_masterclasses, through: :meetings, source: :masterclass
  has_many :learned_recipes, through: :attended_masterclasses, source: :recipes

  validates :first_name, length: { in: 3..25 },
                         format: { with: /\A[A-Za-z\-'éèêëôûüùïîâäç]+\z/ },
                         allow_blank: true
  validates :phone_number, format: { with: /(0|\\+33|0033)[1-9][0-9]{8}/ },
                           allow_blank: true
  validate :time_validate

  def to_param
    [first_name, last_name].join('_').downcase
  end

  private

  def time_validate
    return unless birth_date.present?

    if birth_date > 18.years.ago
      errors.add(:birth_date, 'You should be over 18 years old.')
    elsif birth_date < 120.years.ago
      errors.add(:birth_date, 'You should be under 120 years old.')
    end
  end
end
