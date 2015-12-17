FactoryGirl.define do
  factory :user do
    email 'omg@email.com'
    password 'lolcatwat'
  end

  factory :course do
    title 'Blah'
    description 'How to blah'
    cost '0.00'
  end

  factory :section do
    title 'Blah'
  end
end
