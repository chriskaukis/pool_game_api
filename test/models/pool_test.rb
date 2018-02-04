class TournamentTest < ActiveSupport::TestCase
  test "pool name from number" do
    tests = [
      [1, 'Pool A'],
      [2, 'Pool B'],
      [26, 'Pool Z'],
      [27, 'Pool AA'],
      [28, 'Pool AB'],
      [127, 'Pool DW']
    ]

    tests.each do |t|
      assert Pool.name_from_number(t[0]) == t[1]
    end
  end
end
