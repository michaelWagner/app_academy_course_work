class AlbumsController < ApplicationController
  def new
    @bands = Band.all
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      redirect_to new_band_album_url
    end
  end

  def destroy
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def update

  end

  def album_params
    params.require(:album).permit(:title, :band_id, :live_or_studio)
  end
end
