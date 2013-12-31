# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :surah do
    nb_versets 7
    name_arabic "الفاتحة"
    name_phonetic "The Opening"
    type_surah "Meccan"
  end
end
