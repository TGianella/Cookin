class Meeting < ApplicationRecord
  belongs_to :masterclass
  has_many :reservations
  has_one :chef, through: :masterclass, class_name: 'User'

  validates :start_date, presence: true
  validate :start_date_should_be_in_the_future
  validates :zip_code, presence: true,
                       format: { with: /\A\d{5}\z/ }
  validates :capacity, presence: true,
                       numericality: { in: 1..10 }

  def end_date
    start_date + masterclass.duration * 60
  end

  private

  def start_date_should_be_in_the_future
    return unless start_date.present? && start_date < DateTime.now

    errors.add(:start_date, 'La date choisie pour le cours doit être dans le futur')
  end
end
