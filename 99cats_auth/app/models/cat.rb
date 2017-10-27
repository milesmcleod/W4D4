require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  # freeze ensures that constants are immutable
  CAT_COLORS = %w(purple burnt_orange glass crocodile_skin
  volcanic water bluish rainbow fuzzy spotted white).freeze

  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: CAT_COLORS
  validates :sex, inclusion: %w(M F)

  has_many :rental_requests,
    class_name: :CatRentalRequest,
    dependent: :destroy

  belongs_to :owner,
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id

  def age
    time_ago_in_words(birth_date)
  end
end
