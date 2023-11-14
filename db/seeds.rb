# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# finnhub_client = FinnhubRuby::DefaultApi.new
# stock_symbols = finnhub_client.stock_symbols('US')
top_stocks = [
  'AAPL',
  'MSFT',
  'AMZN',
  'GOOG',
  'FB',
  'TSLA',
  'BRK.A',
  'V',
  'JNJ',
  'WMT',
  'JPM',
  'PG',
  'MA',
  'UNH',
  'NVDA',
  'HD',
  'DIS',
  'BAC',
  'PYPL',
  'ADBE',
  'CMCSA'
]

Stock.destroy_all

top_stocks.each do |stock_symbol|
  stock = Stock.new(
    name: stock_symbol,
    index: stock_symbol,
    quantity: rand(1..100),
    price: rand(1..100)
  )
  stock.save
end
