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

    context "When one regular frame has been played" do
      let(:turns) { [frame] }
      it {
        expect(game.cumulative_total(turns)).to eq([8])
      }
    end

    context "When one frame has been played and it's a spare" do
      let(:turns) { [spare] }
      it {
        expect(game.cumulative_total(turns)).to eq([])
      }
    end

    context "When one frame has been played and it's a strike" do
      let(:turns) { [strike] }
      it {
        expect(game.cumulative_total(turns)).to eq([])
      }
    end

    context "When two frames have been played: a strike then spare" do
      let(:turns) { [strike, spare] }
      it {
        expect(game.cumulative_total(turns)).to eq([20])
      }
    end

    context "When two frames have been played: two strikes" do
      let(:turns) { [strike, strike] }
      it {
        expect(game.cumulative_total(turns)).to eq([])
      }
    end

    context "When three frames have been played: two strikes and a spare" do
      let(:turns) { [strike, strike, spare] }
      it {
        expect(game.cumulative_total(turns)).to eq([27, 47])
      }
    end

    context "When the turns played include ordinary frames" do
      let(:turns) { [frame, frame, frame] }
      it {
        expect(game.cumulative_total(turns)).to eq([8, 16, 24])
      }
    end

    context "When the turns played includes a spare" do
      let(:turns) { [spare, frame, frame] }
      it {
        expect(game.cumulative_total(turns)).to eq([15, 23, 31])
      }
    end

    context "When the turns include two spares in a row" do
      let(:turns) { [spare, spare, frame] }
      it {
        expect(game.cumulative_total(turns)).to eq([17, 32, 40])
      }
    end

    context "When the turns played includes a spare as the most recent (but not final) turn" do
      let(:turns) { [frame, frame, spare] }
      it {
        expect(game.cumulative_total(turns)).to eq([8, 16])
      }
    end

    context "when the turns played includes a strike" do
      let(:turns) { [strike, frame, frame] }
      it {
        expect(game.cumulative_total(turns)).to eq([18, 26, 34])
      }
    end

    context "when the turns played includes a strike as the most recent (but not final) turn" do
      let(:turns) { [frame, frame, strike] }
      it {
        expect(game.cumulative_total(turns)).to eq([8, 16])
      }
    end

    context "when the turns played includes a strike and then a spare" do
      let(:turns) { [strike, spare, frame] }
      it {
        expect(game.cumulative_total(turns)).to eq([20, 35, 43])
      }
    end

    context "when the turns played includes a spare and then a strike" do
      let(:turns) { [spare, strike, frame] }
      it {
        expect(game.cumulative_total(turns)).to eq([20, 38, 46])
      }
    end

    context "when the turns played includes two successive strikes" do
      let(:turns) { [strike, strike, frame] }
      it {
        expect(game.cumulative_total(turns)).to eq([25, 43, 51])
      }
    end

    context "when the turns played includes two successive strikes as the most recent (but not final) two turns" do
      let(:turns) { [frame, strike, strike] }
      it {
        expect(game.cumulative_total(turns)).to eq([8])
      }
    end

    context "when the turns played are a full game with a non-bonus final turn" do
      let(:turns) { Array.new(9, frame).push(final_normal) }
      it {
        expect(game.cumulative_total(turns)).to eq([8, 16, 24, 32, 40, 48, 56, 64, 72, 80])
      }
    end

    context "when the turns played are a full game with a spare final turn" do
      let(:turns) { Array.new(9, frame).push(final_spare) }
      it {
        expect(game.cumulative_total(turns)).to eq([8, 16, 24, 32, 40, 48, 56, 64, 72, 89])
      }
    end

    context "when the turns played are a full game with a single strike final turn" do
      let(:turns) { Array.new(9, frame).push(final_single_strike) }
      it {
        expect(game.cumulative_total(turns)).to eq([8, 16, 24, 32, 40, 48, 56, 64, 72, 87])
      }
    end

    context "when the turns played are a full game with a strike plus spare final turn" do
      let(:turns) { Array.new(9, frame).push(final_strike_spare) }
      it {
        expect(game.cumulative_total(turns)).to eq([8, 16, 24, 32, 40, 48, 56, 64, 72, 92])
      }
    end

    context "when the turns played are a full game with a triple strike final turn" do
      let(:turns) { Array.new(9, frame).push(final_triple_strike) }
      it {
        expect(game.cumulative_total(turns)).to eq([8, 16, 24, 32, 40, 48, 56, 64, 72, 102])
      }
    end

    context "when the turns played are a nine-turn game with all strikes" do
      let(:turns) { Array.new(9, strike) }
      it {
        expect(game.cumulative_total(turns)).to eq([30, 60, 90, 120, 150, 180, 210])
      }
    end

    context "when the turns played are a full game with all strikes" do
      let(:turns) { Array.new(9, strike).push(final_triple_strike) }
      it {
        expect(game.cumulative_total(turns)).to eq([30, 60, 90, 120, 150, 180, 210, 240, 270, 300])
      }
    end
  end
end
