class LineItem < ApplicationRecord
  belongs_to :line_item_date

  validates :name, presence: true
  validates :unit_price, presence: true
  validates :unit_price, numericality: { greater_than: 0 }
  validates :quantity,   presence: true
  validates :quantity,   numericality: { only_integer: true, greater_than: 0 }

  delegate :quote, to: :line_item_date
end
