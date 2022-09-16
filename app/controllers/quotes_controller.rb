class QuotesController < ApplicationController
  before_action :set_quote, only: %i[show edit update destroy]

  def index
    @quotes = Quote.all
  end

  def create
    @quote = Quote.new(resource_params)

    if @quote.save
      redirect_to quotes_path, notice: 'Quote created successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def new
    @quote = Quote.new
  end

  def edit; end

  def update
    if @quote.update(resource_params)
      redirect_to quotes_path, notice: 'Quote updated successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quote.destroy

    redirect_to quotes_path, notice: 'Quote destroyed successfully'
  end

  private

  def set_quote
    @quote = Quote.find(params[:id])
  end

  def resource_params
    params.require(:quote).permit(:name)
  end
end
