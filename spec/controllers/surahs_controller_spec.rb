require 'spec_helper'

describe SurahsController do

  describe "GET 'index'" do
    before(:all) do
      @surah = FactoryGirl.build(:surah)
    end
    it "returns http success" do
      Surah.stub!(:find)
      get 'index'
      response.should be_success
    end

    it "Devrait instancier un SurahPresenter" do
      #Surah.load_surahs
      SurahPresenter.should_receive(:new).with(1,1,7)
      #Surah.stub!(:find).and_return(@surah)
      get 'index'
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
