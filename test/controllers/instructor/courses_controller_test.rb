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
    # course = FactoryGirl.create(:course)
    # visit new_instructor_course_path
    # fill_in "Title", :with => course.title
    # fill_in "Description", :with => course.description
    # fill_in "Cost", :with => course.cost
    # click_button "Create"
    post :create,
      :course => {
        :title => 'Blah',
        :description => 'How to blah',
        :cost => 0.00
      }
    assert_equal 1, user.courses.count
    # Fetch the last course from the database AFTER submitting the form, this will be the newly entered course, which will be the page it will redirect to.
    course = Course.last
    assert_redirected_to instructor_course_path(course.id)
  end
end
