require 'spec_helper'

describe SurahsController do

  describe "GET 'index'" do
    before(:all) do
      @surah = FactoryGirl.build(:surah)

    end
    it "returns http success" do
      SurahPresenter.stub!(:new)
      get 'index'
      response.should be_success
    end

    it "Devrait instancier un SurahPresenter" do
      Surah.load_surahs
      SurahPresenter.should_receive(:new).with(1,1,7)
      Surah.stub!(:find).and_return(@surah)
      get 'index'
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      Surah.load_surahs
      Surah.stub!(:find).and_return(@surah_nas)
      surah_nas = FactoryGirl.build(:surah_nas)
      get 'show', :id => 114
      assigns(:surah_presenter).should be surah_nas
    end
  end

end
