class SurahsController < ApplicationController
  def index
  	@surah_presenter = SurahPresenter.new(1,1,20)
  end

  def show

  end
end
