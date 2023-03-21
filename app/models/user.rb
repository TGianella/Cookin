class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, length: { in: 3..25 },
                         format: { with: /\A[A-Za-z\-'éèêëôûüùïîâäç]+\z/ },
                         allow_blank: true
  validates :phone_number, format: { with: /(0|\\+33|0033)[1-9][0-9]{8}/ },
                           allow_blank: true
  validate :time_validate

  def time_validate
    if birth_date.present?
      if birth_date > 18.years.ago
        errors.add(:birth_date, 'You should be over 18 years old.')
      elsif birth_date < 120.years.ago
        errors.add(:birth_date, 'You should be under 120 years old.')
      end
    end
  end

end
