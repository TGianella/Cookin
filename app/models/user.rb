class User < ApplicationRecord
  include PgSearch::Model

  after_create :welcome_send
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations as chef
  has_many :given_masterclasses, class_name: 'Masterclass', foreign_key: :chef_id
  has_many :taught_recipes, class_name: 'Recipe', foreign_key: :chef_id
  has_many :given_meetings, through: :given_masterclasses, source: :meetings

  # Associations as guest
  has_many :reservations, foreign_key: :guest_id
  has_many :meetings, through: :reservations
  has_many :attended_masterclasses, through: :meetings, source: :masterclass
  has_many :learned_recipes, through: :attended_masterclasses, source: :recipes

  validates :first_name, presence: { message: 'Veuillez renseigner votre prénom' },
                         length: { in: 2..25, message: 'Votre prénom doit contenir entre 2 et 25 caractères' },
                         format: { with: /\A[A-Za-z\-'ÉÈéèêëôûüùïîâäç]+\z/, message: 'Votre prénom ne peut pas contenir de caractères spéciaux' }
  validates :phone_number, format: { with: /(0|\\+33|0033)[1-9][0-9]{8}/, message: 'Merci de renseigner un numéro de téléphone valide' }
  validate :time_validate
  validates :last_name, presence: { message: 'Veuillez renseigner votre nom' },
                         length: { in: 2..25, message: 'Votre nom doit contenir entre 2 et 25 caractères' },
                         format: { with: /\A[A-Za-z\-'ÉÈéèêëôûüùïîâäç\s]+\z/, message: 'Votre nom ne peut pas contenir de caractères spéciaux' }
  validates :city, presence: { message: 'Veuillez renseigner votre ville' },
                         length: { in: 2..25, message: 'Le nom de votre ville doit contenir entre 2 et 25 caractères' },
                         format: { with: /\A[A-Za-z\-'ÉÈéèêëôûüùïîâäçÿœ\s\d]+\z/, message: 'Le nom de votre ville ne peut pas contenir de caractères spéciaux' }
  validates :zip_code, presence: { message: 'Veuillez renseigner votre code postal' },
                         length: { is: 5, message: 'Votre code postal doit contenir 5 chiffres' },
                         format: { with: /\A(0[1-9]|[1-9][0-9])[0-9][0-9][0-9]\z/, message: 'Votre code postal ne peut pas contenir de caractères spéciaux' }

  pg_search_scope :search_by_name,
                  against: %i[first_name last_name],
                  using: { tsearch: { prefix: true } }

  def to_param
    [first_name, last_name].join(' ')
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_from_param(param)
    name_tokens = param.split(' ')
    where(first_name: name_tokens.first, last_name: name_tokens[1..].join(' ')).first
  end

  def self.chefs
    where(is_chef: true).to_a
  end

  def self.guests
    where(is_chef: false).to_a
  end

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  private

  def time_validate

    if birth_date.blank?
      errors.add(:birth_date, 'Veuillez renseigner votre date de naissance')
    elsif birth_date > 18.years.ago
      errors.add(:birth_date, 'Vous devez être âgé de plus de 18 ans.')
    elsif birth_date < 120.years.ago
      errors.add(:birth_date, 'Vous devez être âgé de moins de 120 ans.')
    end
  end
end
