class Tournament
  include ActiveModel::Model

  attr_accessor :teams, :pools, :name

  validates_presence_of :name, :teams, :pools

  def initialize(attributes = {})
    super
    @name ||= "Tournament"
    @pools ||= []
    @teams ||= []
  end
end