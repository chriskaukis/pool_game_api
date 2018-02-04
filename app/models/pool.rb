class Pool
  include ActiveModel::Model

  attr_accessor :name, :games, :teams

  validates_presence_of :name, :games, :teams

  # name_from_number generates a default pool name given a number.
  # Examples:
  # n = 1 returns "Pool A"
  # n = 2 returns "Pool B"
  # n = 27 returns "Pool AA"
  def self.name_from_number(n)
    name = ''
    while n > 0
      mod = (n - 1) % 26
      name = (65 + (mod % 26)).chr + name
      n = (n - mod) / 26
    end
    "Pool #{name}"
  end

  # to_friendly_s returns a friendlier string primary use case being STDOUT/console for debugging.
  def to_friendly_s
    str = ""
    str += '#' * 80 + "\n"
    str += name + "\n"
    str += '-' * 80 + "\n"
    @teams.each do |team|
      str += team.name + "\n"
    end
    str += '-' * 80 + "\n"
    str += "Games (#{games.length})" + "\n"
    str += '-' * 80 + "\n"
    @games.each do |game|
      str += game.name.to_s + "\n"
    end
    str += '#' * 80 + "\n"
    str
  end
end