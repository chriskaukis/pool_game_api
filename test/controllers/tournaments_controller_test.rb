require 'test_helper'

class TournamentsControllerTest < ActionDispatch::IntegrationTest
  test "create a tournament" do
    post tournaments_url, params: { number_of_pools: 4, number_of_teams: 14, number_of_rounds: 1 }
    assert_response :success
    data = JSON.parse(response.body)
    assert data["teams"].length == 14
    assert data["pools"].length == 4
  end
end
