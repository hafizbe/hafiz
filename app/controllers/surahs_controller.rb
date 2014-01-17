class SurahsController < ApplicationController

  def index
    surah_id = nil
    if params[:surah_id].nil?
      surah_id = 1
    else
      surah_id = params[:surah_id]
    end
    surah = Surah.find(surah_id)
  	@surah_presenter = SurahPresenter.new(surah,1,7)
    render "show"
  end

  def show
    surah_id = nil
    if params[:id].nil?
      surah_id = 1
    else
      surah_id = params[:id]
    end
    surah = Surah.find(surah_id)
    @surah_presenter = SurahPresenter.new(surah,1,7)
    render "show"
  end

end
