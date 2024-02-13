class SpotifyTracksController < ApplicationController
  def new
    @spotify_track = SpotifyTrack.new 
  end

  def create
    @spotify_track = current_user.spotify_tracks.build(spotify_track_params) 
    if @spotify_track.save
      age_param = spotify_track_params[:age]
      genre_param = spotify_track_params[:genre]
      tracks = RSpotify::Track.search('genre:#{genre_param} year:#{year_range}', limit: 10)
      binding.pry
      redirect_to root_path, success: t('defaults.message.created', item: SpotifyTrack.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: SpotifyTrack.model_name.human)

      render :new, status: :unprocessable_entity
    end
  end

  private

  def spotify_track_params
    params.require(:spotify_track).permit(:genre, :age, :favorite_artist, :favorite_song)
  end
end
