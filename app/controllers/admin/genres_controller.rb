class Admin::GenresController < ApplicationController

  def index
    @genres = Grenre.all
  end

end
