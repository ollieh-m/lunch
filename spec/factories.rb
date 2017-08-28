FactoryGirl.define do
  factory :menu_bloc_membership do
    menu nil
    menu_bloc nil
  end
  factory :menu_bloc do
    
  end
  factory :user do
    slack_id "MyString"
    name "MyString"
  end
  factory :choice do
    user nil
    options nil
  end
  factory :meal do
    name "MyString"
    description "MyText"
  end
  factory :option do
    menu nil
    meal nil
  end
  factory :menu do
    date "2017-08-25"
  end
  factory :slack_team do
    
  end
end
