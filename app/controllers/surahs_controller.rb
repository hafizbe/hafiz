class SurahsController < ApplicationController
  def index
  	@surah_presenter = SurahPresenter.new(1,1,7)
    i = 1+3
  end

  def show
  end
end
