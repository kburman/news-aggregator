require 'test_helper'

class WebArticleControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get web_article_index_url
    assert_response :success
  end

  test "should get show" do
    get web_article_show_url
    assert_response :success
  end

end
