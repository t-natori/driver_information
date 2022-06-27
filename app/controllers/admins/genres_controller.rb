class Admins::GenresController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admins_genres_path, notice: "ジャンルを作成しました"
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
      redirect_to admins_genres_path, notice: "ジャンルを変更しました"
    else
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    if @genre.delete
      redirect_to admins_genres_path, notice: "ジャンルを削除しました"
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
