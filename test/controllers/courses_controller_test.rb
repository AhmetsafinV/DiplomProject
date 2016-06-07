require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  setup do
    @course = courses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post :create, course: { finished_date: @course.finished_date, finished_time: @course.finished_time, group_id: @course.group_id, name: @course.name, period: @course.period, room_name: @course.room_name, started_date: @course.started_date, started_time: @course.started_time, tutor_id: @course.tutor_id, wday: @course.wday }
    end

    assert_redirected_to course_path(assigns(:course))
  end

  test "should show course" do
    get :show, id: @course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course
    assert_response :success
  end

  test "should update course" do
    patch :update, id: @course, course: { finished_date: @course.finished_date, finished_time: @course.finished_time, group_id: @course.group_id, name: @course.name, period: @course.period, room_name: @course.room_name, started_date: @course.started_date, started_time: @course.started_time, tutor_id: @course.tutor_id, wday: @course.wday }
    assert_redirected_to course_path(assigns(:course))
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete :destroy, id: @course
    end

    assert_redirected_to courses_path
  end
end
