require 'test_helper'

class EnrollmentsControllerTest < ActionController::TestCase
  test "a user can enroll in a course" do
    user = FactoryGirl.create(:user)
    sign_in user
    course = FactoryGirl.create(:course)
    post :create, :course_id => course.id, :enrollment => FactoryGirl.attributes_for(:enrollment).slice(:user_id, :course_id)
    assert_equal 1, user.enrollments.count
  end
end
