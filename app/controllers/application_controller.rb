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
      res = client.get_account_info(token)
      return nil unless res.success?
      email = res.body['users'].first['email']
      @current_user = User.find_or_create_by(email: email)
    end
end
