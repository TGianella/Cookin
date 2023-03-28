class Reservation < ApplicationRecord
  belongs_to :guest, foreign_key: 'guest_id', class_name: 'User'
  belongs_to :meeting
  has_one :masterclass, through: :meeting
  has_one :chef, through: :masterclass, foreign_key: 'chef_id', class_name: 'User'

  after_create :creation_send
  after_update :validation_send

  def creation_send
    ChefMailer.reservation_created_email(self).deliver_now
    UserMailer.reservation_created_email(self).deliver_now
  end

  def validation_send
    ChefMailer.reservation_validated_email(self).deliver_now
    UserMailer.reservation_validated_email(self).deliver_now
  end
end
