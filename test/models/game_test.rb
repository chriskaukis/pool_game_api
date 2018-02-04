class TournamentTest < ActiveSupport::TestCase
  test "new game" do
    team1 = Team.new(name: "Team 1")
    team2 = Team.new(name: "Team 2")
    game = Game.new(team1: team1, team2: team2)
    assert !game.id.nil?
    assert game.id.length > 0
    assert game.name.length > 0
  end
end
