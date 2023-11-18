
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
    finnhub_client = FinnhubRuby::DefaultApi.new
    @profile = finnhub_client.company_profile2({ symbol: @stock.index })
    @financials = finnhub_client.company_basic_financials( @stock.index, 'metric' )
    @quote = finnhub_client.quote( @stock.index )
  end

  def price_update
    @stock = Stock.find_by(index: params[:index])

    new_price = params[:stock][:price].to_f
    @stock.update(price: new_price)
    if @stock.save
    # redirect_to stock_path(@stock)
      render json: { success: true, message: 'Stock price updated successfully' }
    end
  end


  def buy_stock
    @stock = Stock.find(params[:id])
    @user = current_user
    @quantity = stock_params[:quantity].to_f
    total_cost = @stock.price * @quantity
    if @user.budget < total_cost
      redirect_to stocks_path, notice: 'You do not have enough money to purchase this stock.'
    else
      @user.stocks << @stock if !@user.stocks.include?(@stock)
      @user.budget -= total_cost
      current_quantity = @user.stocks.find(@stock.id).quantity
      @user.stocks.find(@stock.id).update(quantity: current_quantity + @quantity)
      @user.save
      redirect_to stocks_path, notice: 'Stock was successfully purchased.'
    end
  end

  def sell_stock
    @stock = Stock.find(params[:id])
    @user = current_user
    @quantity = stock_params[:quantity].to_f
    total_cost = @stock.price * @quantity
    if @user.stocks.include?(@stock)
      @user.stocks.find(@stock.id).quantity -= @quantity
      @user.budget += total_cost
      @user.save
      redirect_to stocks_path, notice: 'Stock was successfully sold.'
    else
      redirect_to stocks_path, notice: 'You do not own this stock.'
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:id, :name, :index, :quantity, :price)
  end

end
