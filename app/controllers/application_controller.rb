class ApplicationController < ActionController::API
  include Banken

  def check
    render json: { user: !!current_user }
  end

  private

    def current_user
      return @current_user if @current_user
      return nil unless token = request.headers['Authorization']
      client = Firebase::Auth::Client.new(ENV['FIREBASE_APIKEY'])
      token.gsub!('Bearer ', '')
      pp client.get_account_info(token)
    end
end
