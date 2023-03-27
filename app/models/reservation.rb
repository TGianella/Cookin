class Reservation < ApplicationRecord
  belongs_to :guest, foreign_key: 'guest_id', class_name: 'User'
  belongs_to :meeting

  after_create :validation_send

  def validation_send
    ChefMailer.reservation_email(self).deliver_now
  end
end
