# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :surah do
    nb_versets 7
    name_arabic "الفاتحة"
    name_phonetic "The Opening"
    type_surah "Meccan"
  end

  factory :surah_nas , :class=> Surah do
    nb_versets 6
    name_arabic "الناس"
    name_phonetic "An-Naas"
    type_surah "Meccan"
  end
end
