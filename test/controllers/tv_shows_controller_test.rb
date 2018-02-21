require 'test_helper'

class TvShowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tv_show = tv_shows(:one)
  end

  test "should get index" do
    get tv_shows_url
    assert_response :success
  end

  test "should get new" do
    get new_tv_show_url
    assert_response :success
  end

  test "should create tv_show" do
    assert_difference('TvShow.count') do
      post tv_shows_url, params: { tv_show: { title: @tv_show.title } }
    end

    assert_redirected_to tv_show_url(TvShow.last)
  end

  test "should show tv_show" do
    get tv_show_url(@tv_show)
    assert_response :success
  end

  test "should get edit" do
    get edit_tv_show_url(@tv_show)
    assert_response :success
  end

  test "should update tv_show" do
    patch tv_show_url(@tv_show), params: { tv_show: { title: @tv_show.title } }
    assert_redirected_to tv_show_url(@tv_show)
  end

  test "should destroy tv_show" do
    assert_difference('TvShow.count', -1) do
      delete tv_show_url(@tv_show)
    end

    assert_redirected_to tv_shows_url
  end
end
