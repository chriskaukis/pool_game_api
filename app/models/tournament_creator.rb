class TournamentCreator
  include ActiveModel::Model

  POOL_PLACEMENTS = ['sequential', 'snake']

  attr_accessor :number_of_rounds, :number_of_teams, :number_of_pools, :pool_placement

  validates_numericality_of :number_of_rounds, greater_than: 0
  validates_numericality_of :number_of_teams, greater_than: 0
  validates_numericality_of :number_of_pools, greater_than: 0
  validates_inclusion_of :pool_placement, in: POOL_PLACEMENTS, allow_blank: true
  validate :pool_validations

  def initialize(attributes = {})
    super
    number_of_rounds ||= 1
    number_of_pools ||= 3
    number_of_teams ||= 6
    pool_placement ||= 'snake'
  end

  def number_of_pools
    @number_of_pools.to_i
  end

  def number_of_teams
    @number_of_teams.to_i
  end

  def number_of_rounds
    @number_of_rounds.to_i
  end

  # pool_validations validates that there are at least 2 teams per pool.
  def pool_validations
    if number_of_pools > 0 && number_of_teams > 0 && (number_of_teams / number_of_pools.to_f).floor < 2
      errors.add(:base, "Each pool must have at least 2 teams (too many pools or not enough teams)")
    end
  end

  # create_snake_sequence_tournament creates and returns a new tournament given the number of pools, number of teams, and number of rounds.
  def create_tournament(tournament_name = 'Tournament')
    return nil unless valid?

    pools = TournamentCreator.create_pools(number_of_pools)
    teams = TournamentCreator.create_teams(number_of_teams)
    if pool_placement == 'sequential'
      TournamentCreator.sequential_pool_placement(pools, teams)
    else
      TournamentCreator.snake_sequence_pool_placement(pools, teams)
    end
    TournamentCreator.games_for_pools(pools, number_of_rounds)

    Tournament.new(name: tournament_name, pools: pools, teams: teams)
  end

  # create_pools given a number of pools will create an array of pools.
  def self.create_pools(number_of_pools)
    pools = []
    (1..number_of_pools).each do |i|
      name = Pool.name_from_number(i)
      pool = Pool.new(name: name, teams: [], games: [])
      pools << pool
    end
    pools
  end

  # create_teams given a number of teams creates an array of teams.
  def self.create_teams(number_of_teams)
    teams = []
    (1..number_of_teams).each do |i|
      name = "Team ##{i}"
      team = Team.new(name: name)
      teams << team
    end
    teams
  end

  # snake_sequence_pool_placement places given teams into given pools using snake sequence.
  def self.snake_sequence_pool_placement(pools, teams)
    teams.each_slice(pools.length).with_index do |a, i|
      a = pools.length.times.map { |i| a[i] } if a.length < pools.length
      a.reverse! unless i.even?
      a.each_with_index do |b, j|
        pools[j].teams << b unless b.nil?
      end
    end
  end

  # sequential_pool_placement places teams in to pools in sequential order.
  def self.sequential_pool_placement(pools, teams)
    teams.each_with_index do |team, i|
      pools[i % pools.length].teams << team
    end
  end

  # games_for_pools handles the generation of games for all the pools in the tournament.
  def self.games_for_pools(pools, number_of_rounds = 1)
    pools.each do |p|
      p.games = TournamentCreator.generate_games(p.teams, number_of_rounds)
    end
  end

  # generate_games a helper method to return all possible game combinations from a list of games and number of rounds to play each team.
  def self.generate_games(teams, number_of_rounds = 1)
    games = []
    teams.combination(2) do |c|
      (0...number_of_rounds).each do |i|
        # Swapping the order emulating, for example, Away @ Home team if order matters in this.
        if i % 2 == 0
          games << Game.new(team1: c[0], team2:c[1])
        else
          games << Game.new(team1: c[1], team2:c[0])
        end
      end
    end
    games
  end
end