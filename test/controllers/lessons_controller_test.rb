require 'test_helper'

class LessonsControllerTest < ActionController::TestCase
  test "only enrolled users can view the lesson show page" do
    user = FactoryGirl.create(:user)
    sign_in user
    course = FactoryGirl.create(:course, :user => user)
    section = FactoryGirl.create(:section, :course => course)
    lesson = FactoryGirl.create(:lesson, :section => section)
    get :show, :id => lesson.id
    assert_redirected_to course_path(course)
  end
end
