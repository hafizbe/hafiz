class SurahPresenter
  attr_accessor :ayahs,:surahs, :surah, :recitators, :to_verse
	
	def initialize(surah, from_verse, to_verse)
		@surah = surah
		@from_verse = from_verse
		@to_verse = choose_verset_maximum to_verse

    @surahs = Surah.all
    @ayahs = @surah.get_ayahs(@from_verse, @to_verse["max_selected"])
    @recitators = Recitator.all
  end



  def choose_verset_minimum(lst_from_versets)
    verset_minimum = 1
    unless lst_from_versets.nil?
      verset_minimum = lst_from_versets
    end
    verset_minimum
  end

  def choose_verset_maximum(lst_to_versets)
    h = Hash.new()
    last_ayah = surah.nb_versets
    h["max"] = last_ayah
    h["max_selected"] = lst_to_versets
    h
  end
	
end