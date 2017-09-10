class HomeController < ApplicationController
  def set_breadcrumbs
    super
    add_breadcrumb Faker::StarWars.character, '#controllerbase'
  end

  def index
    add_breadcrumb Faker::StarWars.character, '#view'
  end
end
