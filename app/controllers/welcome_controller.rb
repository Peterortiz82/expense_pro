class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to expenses_path
    end
  end
end
