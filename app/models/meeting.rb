class Meeting < ApplicationRecord
  belongs_to :masterclass
  has_many :reservations
end
