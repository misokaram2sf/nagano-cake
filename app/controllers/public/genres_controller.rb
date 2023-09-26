class Public::GenresController < ApplicationController

  def show
    @genre = Genre.find(params[:id])
    @genres = Genre.all
    @paginate = @genre.items.page(params[:page]).per(12)
  end
end