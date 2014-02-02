class SurahsController < ApplicationController
  def show
    surah_id = nil
    if params[:id].nil?
      surah_id = 1
    else
      surah_id = params[:id]
    end
    surah = Surah.find(surah_id)
    @surah_presenter = SurahPresenter.new(surah,params[:select_from_verse],params[:select_to_verse],
                                          params[:select_to_verse_check], params[:select_traduction],
                                          params[:select_recitator])
    render "show"
  end

end
