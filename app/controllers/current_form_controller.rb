class CurrentFormController < ApplicationController
  before_filter :authenticate
  layout "standard"

  def index
  end
end
