FactoryGirl.define do
  factory :enrollment do
    user_id 1
    course_id 1
  end

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
    sequence(:email) { |n| "omg#{n}@email.com" }
    password 'lolcatwat'
  end
end
