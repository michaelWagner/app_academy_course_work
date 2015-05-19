class TracksController < ApplicationController
  def new
    @track = Track.new
    render :new
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
    end
  end

  def destroy
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.update(params[:id], track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      redirect_to edit_track_url(@track)
    end
  end

  def track_params
    params.require(:track).permit(:song_name)
  end
end
