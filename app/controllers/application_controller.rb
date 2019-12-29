class ApplicationController < ActionController::API
  include Banken

  def check
    render json: { user: !!current_user }
  end

  private

    def current_user
      return @current_user if @current_user
    end
end
