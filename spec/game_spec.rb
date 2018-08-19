require "game"
require "frame"

describe Game do
  describe "#cumulative_total" do
    let(:game) { Game.new(double("blah")) }
    let(:frame) { Frame.new([5, 3]) }
    let(:spare) { Frame.new([7, 3]) }
    let(:strike) { Frame.new([10, 0]) }
    let(:final_normal) { Frame.new([6, 2, 0]) }
    let(:final_spare) { Frame.new([6, 4, 7]) }
    let(:final_single_strike) { Frame.new([10, 4, 1]) }
    let(:final_strike_spare) { Frame.new([10, 5, 5]) }
    let(:final_triple_strike) { Frame.new([10, 10, 10]) }

    context "When the turns played include ordinary frames" do
      let(:turns) { [frame, frame, frame] }
      it {
        expect(game.cumulative_total(turns)).to eq(24)
      }
    end

    context "When the turns played includes a spare" do
      let(:turns) { [spare, frame, frame] }
      it {
        expect(game.cumulative_total(turns)).to eq(31)
      }
    end

    context "When the turns include two spares in a row" do
      let(:turns) { [spare, spare, frame] }
      it {
        expect(game.cumulative_total(turns)).to eq(17 + 15 + 8)
      }
    end

    context "When the turns played includes a spare as the most recent (but not final) turn" do
      let(:turns) { [frame, frame, spare] }
      it {
        expect(game.cumulative_total(turns)).to eq(26)
      }
    end

    context "when the turns played includes a strike" do
      let(:turns) { [strike, frame, frame] }
      it {
        expect(game.cumulative_total(turns)).to eq(34)
      }
    end

    context "when the turns played includes a strike as the most recent (but not final) turn" do
      let(:turns) { [frame, frame, strike] }
      it {
        expect(game.cumulative_total(turns)).to eq(26)
      }
    end

    context "when the turns played includes a strike and then a spare" do
      let(:turns) { [strike, spare, frame] }
      it {
        expect(game.cumulative_total(turns)).to eq(20 + 15 + 8)
      }
    end

    context "when the turns played includes a spare and then a strike" do
      let(:turns) { [spare, strike, frame] }
      it {
        expect(game.cumulative_total(turns)).to eq(20 + 18 + 8)
      }
    end

    context "when the turns played includes two successive strikes" do
      let(:turns) { [strike, strike, frame] }
      it {
        expect(game.cumulative_total(turns)).to eq(51)
      }
    end

    context "when the turns played includes two successive strikes as the most recent (but not final) two turns" do
      let(:turns) { [frame, strike, strike] }
      it {
        expect(game.cumulative_total(turns)).to eq(38)
      }
    end

    context "when the turns played are a full game with a non-bonus final turn" do
      let(:turns) { Array.new(9, frame).push(final_normal) }
      it {
        expect(game.cumulative_total(turns)).to eq(80)
      }
    end

    context "when the turns played are a full game with a spare final turn" do
      let(:turns) { Array.new(9, frame).push(final_spare) }
      it {
        expect(game.cumulative_total(turns)).to eq(72 + 17)
      }
    end

    context "when the turns played are a full game with a single strike final turn" do
      let(:turns) { Array.new(9, frame).push(final_single_strike) }
      it {
        expect(game.cumulative_total(turns)).to eq(72 + 15)
      }
    end

    context "when the turns played are a full game with a strike plus spare final turn" do
      let(:turns) { Array.new(9, frame).push(final_strike_spare) }
      it {
        expect(game.cumulative_total(turns)).to eq(72 + 20)
      }
    end

    context "when the turns played are a full game with a triple strike final turn" do
      let(:turns) { Array.new(9, frame).push(final_triple_strike) }
      it {
        expect(game.cumulative_total(turns)).to eq(72 + 30)
      }
    end

    context "when the turns played are a nine-turn game with all strikes" do
      let(:turns) { Array.new(9, strike) }
      it {
        expect(game.cumulative_total(turns)).to eq(30*7 + 20 + 10)
      }
    end

    context "when the turns played are a full game with all strikes" do
      let(:turns) { Array.new(9, strike).push(final_triple_strike) }
      it {
        expect(game.cumulative_total(turns)).to eq(30*9 + 30)
      }
    end

  end
end
