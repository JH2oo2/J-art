
class DashboardChannel < ApplicationCable::Channel

  def subscribed
    stream_from "dashboard_channel"
  end

  def unsubscribed
  end



  private

  # def handle_message(message)
  #   puts "Recieved message: #{message}"
  # end

  # def hande_error(error)
  #   puts "Error: #{error}"
  # end

  # def handle_close
  #   puts "Connection closed"
  # end

  # def send_subscription_requests

  # end




end
