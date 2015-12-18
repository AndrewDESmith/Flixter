require 'test_helper'

class Instructor::LessonsControllerTest < ActionController::TestCase
  test "an instructor can create a lesson within a section of their course" do
    user = FactoryGirl.create(:user)
    sign_in user
    course = FactoryGirl.create(:course, :user => user)
    section = FactoryGirl.create(:section, :course => course)
    post :create, :section_id => section.id, :lesson => FactoryGirl.attributes_for(:lesson).slice(:title, :subtitle)
    assert_equal 1, section.lessons.count
    assert_redirected_to instructor_course_path(course.id)
  end

  test "only the instructor who created the course can create lessons within the same course" do
    user = FactoryGirl.create(:user)
    sign_in user
    user2 = FactoryGirl.create(:user)
    course = FactoryGirl.create(:course, :user => user2)
    section = FactoryGirl.create(:section, :course => course)
    post :create, :section_id => section.id, :lesson => FactoryGirl.attributes_for(:lesson).slice(:title, :subtitle)
    assert_equal 0, section.lessons.count
    assert_response :unauthorized
  end
end
