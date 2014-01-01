require 'spec_helper'

describe Surah do

  before(:all) do
    @surah = FactoryGirl.build(:surah)
  end

  it { should have_many(:verses) }

  it { @surah.should be_valid}

  it 'Devrait avoir 1 verset au minimum' do
    @surah.nb_versets.should be 7
  end

  it 'Devrait ne pas être valide' do
    should_not be_valid
  end

  it 'Devrait répondre à tous les attributs' do
    should respond_to(:nb_versets)
    should respond_to(:name_phonetic)
    should respond_to(:name_arabic)
    should respond_to(:type_surah)


  end

  it "Devrait répondre à toutes les méthodes " do
    Surah.should respond_to(:load_surahs)
    Surah.should respond_to(:load_verses)
  end

  it "Devrait avoir  114 sourates " do
    Surah.load_surahs
    nb_sourates = Surah.count
    nb_sourates.should be 114
  end



end
