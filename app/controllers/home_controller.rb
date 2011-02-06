class HomeController < ApplicationController
  def index
    @players = Player.all
  end

end
