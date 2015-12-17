require 'test_helper'

class Instructor::SectionsControllerTest < ActionController::TestCase
  test "an instructor can create a new section within a course" do
    user = FactoryGirl.create(:user)
    sign_in user
    course = FactoryGirl.create(:course)
    post :create, :course_id => course.id, :section => FactoryGirl.attributes_for(:section).slice(:title)
    assert_equal 1, course.sections.count
    assert_redirected_to instructor_course_path(course.id)
  end
end
