require 'spec_helper'

describe Surah do

  before(:all) do
    @surah = FactoryGirl.build(:surah)
  end

  it 'Devrait avoir 1 verset au minimum' do
    @surah.nb_versets.should be 7
  end

  it 'Devrait ne pas être valide' do
    should_not be_valid
  end

  it 'Devrait être valide' do
    surah = Surah.new(name_arabic: "Al-Fatiha", name_phonetic: "Al-fatiha", type_surah: "Meccan", nb_versets: 7)
    surah.should be_valid
  end

  it 'Devrait répondre à tous les attributs' do
    should respond_to(:nb_versets)
    should respond_to(:name_phonetic)
    should respond_to(:name_arabic)
    should respond_to(:type_surah)
  end

end
