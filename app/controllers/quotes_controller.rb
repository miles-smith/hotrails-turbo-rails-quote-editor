class QuotesController < ApplicationController
  before_action :set_quote, only: %i[show edit update destroy]

  def index
    @quotes = current_company.quotes.ordered
  end

  def create
    @quote = current_company.quotes.build(resource_params)

    if @quote.save
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: 'Quote created successfully' }
        format.turbo_stream
      end
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

    respond_to do |format|
      format.html { redirect_to quotes_path, notice: 'Quote destroyed successfully' }
      format.turbo_stream
    end
  end

  private

  def set_quote
    @quote = current_company.quotes.find(params[:id])
  end

  def resource_params
    params.require(:quote).permit(:name)
  end
end
