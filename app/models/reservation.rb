class Reservation < ApplicationRecord
  belongs_to :guest, foreign_key: 'guest_id', class_name: 'User'
  belongs_to :meeting
  has_one :masterclass, through: :meeting
  has_one :chef, through: :masterclass, foreign_key: 'chef_id', class_name: 'User'

  after_create :creation_send
  after_update :validation_send

  validates :guest,
            uniqueness: { scope: :meeting,
                          message: "un utilisateur ne peut pas s'inscrire deux fois à la même session" }
  validate :only_one_reservation_per_masterclass_per_user, on: :create
  validate :meeting_has_free_spots
  validate :chef_cannot_book_his_own_meeting

  def creation_send
    ChefMailer.reservation_created_email(self).deliver_now
    UserMailer.reservation_created_email(self).deliver_now
  end

  def validation_send
    ChefMailer.reservation_validated_email(self).deliver_now
    UserMailer.reservation_validated_email(self).deliver_now
  end

  private

  def only_one_reservation_per_masterclass_per_user
    guest.attended_masterclasses.each { |a| puts a.title }
    return unless guest.attended_masterclasses.include?(meeting.masterclass)

    errors.add(:meeting, "un utilisateur ne peut pas s'inscrire deux fois pour la même masterclass")
  end

  def meeting_has_free_spots
    return unless meeting.free_spots <= 0

    errors.add(:meeting, "la session n'a plus de places disponibles")
  end

  def chef_cannot_book_his_own_meeting
    return unless guest == meeting.chef

    errors.add(:user, "un chef ne peut pas s'inscrire à sa propre session")
  end
end
