
class StocksController < ApplicationController

  def api
    @stocks = Stock.all
    render json: @stocks
  end

  def index
    @stocks = Stock.all

    # @stock_data = ActionCable.server.broadcast('dashboard_channel', { data: @data })
  end

  def show
    @stock = Stock.find(params[:id])
  end

  def price_update
    @stock = Stock.find(params[:id])

    new_price = params[:stock][:price].to_f
    @stock.update(price: new_price)
    if @stock.save
    # redirect_to stock_path(@stock)
      render json: { success: true, message: 'Stock price updated successfully' }
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:id, :name, :index, :quantity, :price)
  end

end
