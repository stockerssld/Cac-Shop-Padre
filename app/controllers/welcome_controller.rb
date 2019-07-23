class WelcomeController < ApplicationController
  def index
  end

  def unregistered
  end

  def admin
    render layout: "admin"
  end
end