ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"

require_relative "cms"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index_about_body
    get "/about.txt"
    assert_equal 200, last_response.status
    assert_equal "text/plain", last_response["Content-Type"]
    assert_equal "Hi Trudy", last_response.body
  end

  def test_no_response_file_path
    get "/rubbish.ext"
    assert_equal 302, last_response.status
    get last_response["Location"]
    assert_equal 200, last_response.status
    assert_includes last_response.body, "rubbish.ext does not exist"
  end


end