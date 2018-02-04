class TournamentCreatorTest < ActiveSupport::TestCase
  test "creates a list of pools" do
    number_of_pools = 3
    pools = TournamentCreator.create_pools(number_of_pools)
    assert pools.length == number_of_pools
    pools.each do |pool|
      assert pool.is_a?(Pool)
    end
  end

  test "creates a list of teams" do
    number_of_teams = 32
    teams = TournamentCreator.create_teams(number_of_teams)
    assert teams.length == number_of_teams
    teams.each do |team|
      assert team.is_a?(Team)
    end
  end

  test "snake sequence pool placement" do
    pools = TournamentCreator.create_pools(4)
    teams = TournamentCreator.create_teams(14)
    TournamentCreator.snake_sequence_pool_placement(pools, teams)

    assert pools[0].teams.length == 3
    assert pools[0].teams[0] == teams[0]
    assert pools[0].teams[1] == teams[7]
    assert pools[0].teams[2] == teams[8]

    assert pools[1].teams.length == 3
    assert pools[1].teams[0] == teams[1]
    assert pools[1].teams[1] == teams[6]
    assert pools[1].teams[2] == teams[9]

    assert pools[2].teams.length == 4
    assert pools[2].teams[0] == teams[2]
    assert pools[2].teams[1] == teams[5]
    assert pools[2].teams[2] == teams[10]
    assert pools[2].teams[3] == teams[13]

    assert pools[3].teams.length == 4
    assert pools[3].teams[0] == teams[3]
    assert pools[3].teams[1] == teams[4]
    assert pools[3].teams[2] == teams[11]
    assert pools[3].teams[3] == teams[12]
  end

  test "sequential pool placement" do
    pools = TournamentCreator.create_pools(4)
    teams = TournamentCreator.create_teams(14)
    TournamentCreator.sequential_pool_placement(pools, teams)
    teams.each_with_index do |team, i|
      assert pools[i % pools.length].teams.include?(team)
    end
  end

  test "generating games" do
    teams = TournamentCreator.create_teams(3)
    games = TournamentCreator.generate_games(teams)
    assert games.length == 3
    games.each do |game|
      assert game.is_a?(Game)
    end
  end

  test "create tournament" do
    tournament_creator = TournamentCreator.new(number_of_pools: 4, number_of_teams: 14, number_of_rounds: 1)
    assert tournament_creator.valid?
    assert tournament_creator.create_tournament("Not the Frozen Four").name == "Not the Frozen Four"
    # In actual production code at my company or anyone elses company I would take the time and check every  attribute/property with expected output from the given input.
  end
end
