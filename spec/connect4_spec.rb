require './lib/main'

describe Game do
  game = Game.new
  describe ".initialize" do
    it "initializes new game with the 6x7 game board(array)" do 
      expect(game.board).to eql( Array.new(6) {Array.new(7) {'🟦'}} )
    end
  end

  describe "#drop_disc" do
    it "drops a disc into the game board" do
      game.drop_disc(0, 'd')
      expect(game.board[5][0]).to eql('d')
    end
  end

  describe "#drop_disc" do
    it "drops a disc on top of another disc" do
      game.drop_disc(0, 'd')
      expect(game.board[4][0]).to eql('d')
    end
  end

  describe "#drop_disc" do
    it "prints out 'This column is full' when the column is full" do
      game.drop_disc(0, 'd')
      game.drop_disc(0, 'd')
      game.drop_disc(0, 'd')
      game.drop_disc(0, 'd')
      expect(game.drop_disc(0, 'd')).to eql(nil)
    end
  end

  describe "#clear" do
    it "refreshes the game board" do
      expect(game.clear).to eql( Array.new(6) {Array.new(7) {'🟦'}} )
    end
  end

  describe "#valid?" do
    it "checks if child node of the current position is available to add to queue" do
      game.drop_disc(0, 'd')
      game.drop_disc(1, 'd')
      game.drop_disc(2, 'd')
      game.drop_disc(3, 'd')
      expect(game.valid?([5,1], [1,1], 'd')).to eql(true)
      expect(game.valid?([5,4],[[5,1], [1,1]], 'd')).to eql(false)
      expect(game.valid?([5,3],[[5,3], [1,1]], 'd')).to eql(false)
    end
  end

  describe "#four_in_row?" do
    it "Searches if there are four discs in row horizontally" do
      game.clear
      game.drop_disc(0, 'd')
      game.drop_disc(1, 'd')
      game.drop_disc(2, 'd')
      game.drop_disc(3, 'd')
      expect(game.four_in_row?([5,1], 'd', 'x')).to eql(true)
      expect(game.four_in_row?([5,0], 'd', 'x')).to eql(true)
      expect(game.four_in_row?([5,3], 'd', 'x')).to eql(true)
      expect(game.four_in_row?([5,2], 'd', 'x')).to eql(true)
    end
  end

  describe "#four_in_row?" do
    it "Searches if there are four discs in row diagnolly" do
      game.clear
      game.drop_disc(0, 'd')
      2.times {game.drop_disc(1, 'd')}
      3.times {game.drop_disc(2, 'd')}
      4.times {game.drop_disc(3, 'd')}
      expect(game.four_in_row?([5,0], 'd', 'z')).to eql(true)
      expect(game.four_in_row?([5,1], 'd', 'z')).to eql(false)
      expect(game.four_in_row?([4,1], 'd', 'z')).to eql(true)
      expect(game.four_in_row?([2,3], 'd', 'z')).to eql(true)
    end
  end


  describe "#four_in_row?" do
    it "Searches if there are four discs in row vertically" do
      game.clear
      4.times {game.drop_disc(3, 'd')}
      expect(game.four_in_row?([5,3], 'd', 'y')).to eql(true)
      expect(game.four_in_row?([2,3], 'd', 'y')).to eql(true)
      expect(game.four_in_row?([4,3], 'd', 'y')).to eql(true)
      expect(game.four_in_row?([2,4], 'd', 'y')).to eql(false)
    end
  end

  describe "#any_win?" do
    it "Searches if there is any four in success in any direction" do
      expect(game.any_win?([5,3], 'd')).to eql(true)
      expect(game.any_win?([2,4], 'd')).to eql(false)
    end
  end
=begin
  describe "#display_board" do
    it "displays the board in a aesthetic way!" do
      game.clear
      4.times {game.drop_disc(3, '🔴')}
      expect(game.display_board).to
      eql([['🟦', '🟦', '🟦', '🟦', '🟦', '🟦', '🟦'],
           ['🟦', '🟦', '🟦', '🟦', '🟦', '🟦', '🟦'],
           ['🟦', '🟦', '🟦', '🔴', '🟦', '🟦', '🟦'],
           ['🟦', '🟦', '🟦', '🔴', '🟦', '🟦', '🟦'],
           ['🟦', '🟦', '🟦', '🔴', '🟦', '🟦', '🟦'],
           ['🟦', '🟦', '🟦', '🔴', '🟦', '🟦', '🟦']]
       )
    end
  end
=end

end
