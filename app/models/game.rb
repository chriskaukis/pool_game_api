require 'securerandom'

class Game
  include ActiveModel::Model

  attr_accessor :id, :name, :team1, :team2

  validates_presence_of :id, :name, :team1, :team2

  def initialize(attributes = {})
    super
    @id ||= SecureRandom.uuid

    if @name.nil? && !@team1.nil? && !@team2.nil?
      @name = "#{@team1.name} vs. #{@team2.name}"
    else
      @name ||= "Game #{@id}"
    end
  end
end