class Meeting < ApplicationRecord
  belongs_to :masterclass
  has_many :reservations

  def end_date
    start_date + masterclass.duration * 60
  end
end
