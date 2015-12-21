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
    # .attributes_for gives the attributes without being connected to a database model
    # .slice takes a hash
    post :create, :course => FactoryGirl.attributes_for(:course).slice(:title, :description, :cost)
    assert_equal 1, user.courses.count
    # Fetch the last course from the database AFTER submitting the form, this will be the newly entered course, which will be the page it will redirect to.
    course = Course.last
    assert_redirected_to instructor_course_path(course.id)
  end

  test "refuse invalid data on course creation" do
    user = FactoryGirl.create(:user)
    sign_in user
    post :create, :course => {
      :title => '',
      :description => '',
      :cost => -1
    }
    assert_response :unprocessable_entity
  end

  test "only the creator of a course can view the instructor show page" do
    user = FactoryGirl.create(:user)
    course = FactoryGirl.create(:course, :user => user)
    user2 = FactoryGirl.create(:user)
    sign_in user2
    get :show, :id => course.id
    assert_response :unauthorized
  end
end
