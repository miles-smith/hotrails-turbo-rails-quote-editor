class User < ApplicationRecord
  devise :database_authenticatable, :validatable

  belongs_to :company

  delegate :name, to: :company, prefix: true

  def name
    email.split('@').first.capitalize
  end
end
