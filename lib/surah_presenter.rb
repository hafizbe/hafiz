class SurahPresenter
  attr_accessor :ayahs
	def initialize(surah_id, from_verse, to_verse)
		@surah = Surah.find(surah_id)
		@from_verse = from_verse
		@to_verse = to_verse

    @ayahs = @surah.get_ayahs(@from_verse, @to_verse)
	end


end