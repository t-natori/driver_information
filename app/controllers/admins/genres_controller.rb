class Admins::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.find(params[:id])
    if @genre.save
      redirect_to admins_genres_path, notice: "ジャンルが作成されました"
    else
      @genre = Genre.new
      @genres = Genre.all
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admins_genres_path, notice: "ジャンルが変更されました"
    else
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    if @genre.delete
      redirect_to admins_genres_path, notice: "ジャンルが削除されました"
    else
      @genre = Genre.new
      @genres = Genre.all
      render :index
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
