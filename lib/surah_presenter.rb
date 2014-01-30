class SurahPresenter
  attr_accessor :ayahs,:surahs, :surah, :recitators,:recitator, :to_verse, :from_verse, :traduction, :langues, :ayahs_traducted
	
	def initialize(surah, from_verse, to_verse, to_verse_check, select_traduction, recitator)
		@surah = surah
		@from_verse = choose_verset_minimum from_verse
		@to_verse = choose_verset_maximum to_verse, to_verse_check
    @traduction = choose_traduction select_traduction
    @langues = get_langue
    @recitator = choose_recitator_name recitator

    @surahs = Surah.all
    @ayahs_traducted = @surah.get_traduction @traduction, @from_verse, @to_verse["max_selected"]
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

  def choose_verset_maximum(lst_to_versets, lst_to_versets_check)
    h = Hash.new()
    last_ayah = surah.nb_versets
    h["max"] = last_ayah
    h["max_selected"] = last_ayah
    unless lst_to_versets.nil? || lst_to_versets_check == 0.to_s
      h["max_selected"] = lst_to_versets
    end
    h
  end

  def choose_traduction(select_traduction)
    traduction = "none"
    unless select_traduction.nil?
      traduction  = select_traduction
    end
    traduction
  end

  def choose_recitator_name(lst_recitator_name)
    recitator_name = "Mishary"
    unless lst_recitator_name.nil?
      recitator_name  = lst_recitator_name
    end
    recitator_name
  end

  def get_langue
    hm = {}
    hm['none'] = 'None'
    hm['fr'] = 'French'
    hm['en'] = 'English'
    hm['es'] = 'Spanish'
    hm
  end
	
end