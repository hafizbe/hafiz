# == Schema Information
#
# Table name: surahs
#
#  id            :integer          not null, primary key
#  nb_versets    :integer
#  name_arabic   :string(255)
#  name_phonetic :string(255)
#  type_surah    :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Surah < ActiveRecord::Base
end
