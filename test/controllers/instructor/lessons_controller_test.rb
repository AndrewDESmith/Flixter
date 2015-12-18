require 'test_helper'

class Instructor::LessonsControllerTest < ActionController::TestCase
  test "an instructor can create a lesson within a section of a course" do
    user = FactoryGirl.create(:user)
    sign_in user
    course = FactoryGirl.create(:course)
    section = FactoryGirl.create(:section)
    post :create, :section_id => section.id, :lesson => FactoryGirl.attributes_for(:lesson).slice(:title, :subtitle)
    assert_equal 1, course.section.lessons.count
    assert_redirected_to instructor_course_path(course.id)
  end
end
