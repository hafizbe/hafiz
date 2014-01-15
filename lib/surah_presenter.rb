class SurahPresenter
  attr_accessor :ayahs,:surahs
	
	def initialize(surah, from_verse, to_verse)
		@surah = surah
		@from_verse = from_verse
		@to_verse = to_verse

    @surahs = Surah.all
    @ayahs = @surah.get_ayahs(@from_verse, @to_verse)
    @recitators = Recitator.all
	end
	
end