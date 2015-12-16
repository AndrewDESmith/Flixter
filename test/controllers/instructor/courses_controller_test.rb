require 'test_helper'

class Instructor::CoursesControllerTest < ActionController::TestCase
  # A user who isn't signed in is redirected to the login page
  # test "user new page" do
  #   assert_redirected_to new_user_session_path
  # end

  test "a signed in user can access the new course page" do
    user = FactoryGirl.create(:user)
    sign_in user
    get :new
    assert_response :success
  end

  test "a user can create a new course" do
    user = FactoryGirl.create(:user)
    sign_in user
    course = FactoryGirl.create(:course)
    post :create, :course_id => course.id,
       :course => {
        :title => course.title,
        :description => course.description,
        :cost => course.cost
      }
    assert_equal 1, user.courses.count
    assert_redirected_to instructor_course_path(course.id)
  end
end
