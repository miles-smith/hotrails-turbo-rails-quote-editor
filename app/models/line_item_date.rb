class LineItemDate < ApplicationRecord
  belongs_to :quote

  scope :ordered, -> { order(date: :asc) }

  validates :date, presence: true
  validates :date, uniqueness: { scope: :quote_id }

  def previous_date
    quote.line_item_dates.ordered.where("date < ?", date).last
  end
end
