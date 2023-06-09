class Quote < ApplicationRecord
  belongs_to :company
  has_many :line_item_dates, dependent: :destroy
  has_many :line_items, through: :line_item_dates

  scope :ordered, -> { order(id: :desc) }

  broadcasts_to ->(quote) { [quote.company, :quotes] }, inserts_by: :prepend
  # NOTE: The above is syntactic sugar for implementing all of the below succinctly
  # after_create_commit  -> { broadcast_prepend_later_to :quotes }
  # after_update_commit  -> { broadcast_replace_later_to :quotes }
  # after_destroy_commit -> { broadcast_remove_to :quotes }

  validates :name, presence: true

  def total_price
    line_items.sum(&:total_price)
  end
end
