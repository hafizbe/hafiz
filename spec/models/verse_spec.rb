require 'spec_helper'

describe Verse do
  it { should belong_to(:surah) }

  it "Devrait répondre à tous les attributs et méthodes" do
    should respond_to(:surah_id)
    should respond_to(:position)
  end


  it "Une sourate est relié à un ou plusieurs versets" do
    surah  = Surah.new(id:1)
    surah.save
    verse = Verse.new

    verse.surah = surah
    verse.save
    surah.verses.should include(verse)
  end

  it "Devrait avoir  6236 versets "

end
