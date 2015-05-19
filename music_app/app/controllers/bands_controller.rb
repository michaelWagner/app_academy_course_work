class BandsController < ApplicationController
  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      redirect_to new_band_url
    end
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def destroy
    Band.destroy(params[:id])
    redirect_to bands_url
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def update
    @band = Band.update(params[:id], band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      redirect_to edit_band_url
    end
  end

  def band_params
    params.require(:band).permit(:name)
  end
end
