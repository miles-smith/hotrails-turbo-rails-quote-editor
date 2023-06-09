require "test_helper"

class QuoteTest < ActiveSupport::TestCase
  test 'should be invalid without a name' do
    quote = Quote.new

    refute quote.valid?
    assert_includes quote.errors.details[:name], error: :blank
  end

  test 'should enforce not null constraint for name' do
    quote = Quote.new

    assert_raises ActiveRecord::NotNullViolation do
      quote.save(validate: false)
    end
  end

  test "#total_price returns the sum of the total price of all line items" do
    assert_equal 2500, quotes(:first).total_price
  end
end
