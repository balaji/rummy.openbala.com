class SessionController < ApplicationController
  def new
  end

  def create
    if open_id?(params[:name])
      open_id_authentication(params[:name])
    end
  end

  protected
    def open_id_authentication(identity_url)
      authenticate_with_open_id(identity_url) do |status, identity_url|
        case status
        when :missing
          failed_login("server missing")
        when :canceled
          failed_login("authentication canceled")
        when :failed
          failed_login("failed authentication")
        when :successful
          successful_login
        end
      end
    end

  private
    def failed_login(message)
      flash[:error] = message
    end

    def successful_login
      flash[:error] = "successfull"
    end
end
