class QuotesController < ApplicationController
  before_action :set_quote, only: %i[show edit update destroy]

  def index
    @quotes = current_company.quotes.ordered
  end

  def create
    @quote = current_company.quotes.build(resource_params)

    if @quote.save
      respond_to do |format|
        notice = 'Quote created successfully'

        format.html { redirect_to quotes_path, notice: notice }
        format.turbo_stream { flash.now[:notice] = notice }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @line_item_dates = @quote.line_item_dates.ordered.includes(:line_items)
  end

  def new
    @quote = Quote.new
  end

  def edit; end

  def update
    if @quote.update(resource_params)
      respond_to do |format|
        notice = 'Quote updated successfully'

        format.html { redirect_to quotes_path, notice: notice }
        format.turbo_stream { flash.now[:notice] = notice }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quote.destroy

    respond_to do |format|
      notice = 'Quote destroyed successfully'

      format.html { redirect_to quotes_path, notice: notice }
      format.turbo_stream { flash.now[:notice] = notice }
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
