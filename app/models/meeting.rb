class Meeting < ApplicationRecord
  belongs_to :masterclass
  has_many :reservations
  has_one :chef, through: :masterclass, class_name: 'User'

  def end_date
    start_date + masterclass.duration * 60
  end
end
