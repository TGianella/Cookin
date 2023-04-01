class Meeting < ApplicationRecord
  belongs_to :masterclass
  has_many :reservations, dependent: :destroy
  has_one :chef, through: :masterclass, class_name: 'User'

  validates :start_date, presence: { message: 'Une date est obligatoire' }
  validate :start_date_should_be_in_the_future,
           :meetings_should_not_overlap_with_others_from_same_chef
  validates :zip_code, presence: { message: 'Le code postal est obligatoire' },
                       format: { with: /\A\d{5}\z/, message: 'Veuillez renseigner un code postal valide' }
  validates :capacity, presence: { message: 'Veuillez renseigner un nombre de convives' },
                       numericality: { in: 1..10, message: 'Veuillez rentrer un nombre' }

  def end_date
    start_date + masterclass.duration * 60
  end

  def free_spots
    capacity - reservations.count
  end

  def pending_reservations
    reservations.where(status: false).to_a
  end

  def confirmed_reservations
    reservations.where(status: true).to_a
  end

  def chefs_other_meetings
    chef.given_meetings - [self]
  end

  private

  def start_date_should_be_in_the_future
    return unless start_date.present? && start_date < DateTime.now

    errors.add(:start_date, 'La date choisie pour le cours doit être dans le futur')
  end

  def meetings_should_not_overlap_with_others_from_same_chef
    chefs_other_meetings.each do |meeting|
      unless start_date.present? && (start_date > meeting.end_date || end_date < meeting.start_date)
        errors.add(:start_date,
                   "La session ne peut pas avoir lieu en même temps qu'une autre de vos sessions")
      end
    end
  end
end
