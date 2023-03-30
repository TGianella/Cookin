class Category < ApplicationRecord
  include PgSearch::Model
  
  has_and_belongs_to_many :masterclasses

  pg_search_scope :search_by_name,
                  against: %i[name],
                  using: { tsearch: { prefix: true } }
end
