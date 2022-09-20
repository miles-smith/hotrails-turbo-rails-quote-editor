class Quote < ApplicationRecord
  belongs_to :company

  scope :ordered, -> { order(id: :desc) }

  broadcasts_to ->(quote) { [quote.company, :quotes] }, inserts_by: :prepend
  # NOTE: The above is syntactic sugar for implementing all of the below succinctly
  # after_create_commit  -> { broadcast_prepend_later_to :quotes }
  # after_update_commit  -> { broadcast_replace_later_to :quotes }
  # after_destroy_commit -> { broadcast_remove_to :quotes }

  validates :name, presence: true
end
