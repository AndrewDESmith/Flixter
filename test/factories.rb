FactoryGirl.define do
  factory :lesson do
    title 'Blah'
    subtitle 'More Blah'
  end

  factory :section do
    title 'Blah'
  end

  factory :course do
    title 'Blah'
    description 'How to blah'
    cost '0.00'
  end

  factory :user do
    email 'omg@email.com'
    password 'lolcatwat'
  end
end
