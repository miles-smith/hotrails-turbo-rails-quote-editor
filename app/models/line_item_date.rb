class LineItemDate < ApplicationRecord
  belongs_to :quote

  scope :ordered, -> { order(date: :asc) }

  validates :date, presence: true
  validates :date, uniqueness: { scope: :quote_id }
end
