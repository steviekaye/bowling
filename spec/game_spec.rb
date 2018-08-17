require "game"
require "frame"

describe Game do
  #let(:t1) { [[3, 5], [5, 0], [9, 0], [3, 5], [3, 1], [2, 8], [1, 2], [10, 0], [4, 0], [8, 1]] }
  let(:f1) { Frame.new() }
  let(:f2) { Frame.new() }
  let(:f3) { Frame.new() }
  let(:f4) { Frame.new() }
  let(:f5) { Frame.new() }
  let(:f6) { Frame.new() }
  let(:f7) { Frame.new() }
  let(:f8) { Frame.new() }
  let(:f9) { Frame.new() }
  let(:f10) { Frame.new() }
  let(:t1) { [f1, f2] }
  let(:t2) { [f1, f2, f3, f4] }
  let(:t3) { [f1, f2, f3, f4, f5, f6, f7, f8, f9, f10] }


  describe "#total_score" do
    context "When given two turns with a total score of 13" do
      it {
        f1.instance_variable_set(:@frame, [3, 5])
        f2.instance_variable_set(:@frame, [5, 0])

        expect(Game.new(double("blah")).total_score(t1)).to eql(13)
      }
    end

    context "When given two turns (with a strike) with a total score of 22" do
      it {
        f1.instance_variable_set(:@frame, [10, 0])
        f2.instance_variable_set(:@frame, [4, 2])

        expect(Game.new(double("blah")).total_score(t1)).to eql(22)
      }
    end

    context "When given two turns (with two strikes) with a total score of 20" do
      it {
        f1.instance_variable_set(:@frame, [10, 0])
        f2.instance_variable_set(:@frame, [10, 0])

        expect(Game.new(double("blah")).total_score(t1)).to eql(20)
      }
    end

    context "When given two turns (with a spare) with a total score of 20" do
      it {
        f1.instance_variable_set(:@frame, [7, 3])
        f2.instance_variable_set(:@frame, [4, 2])

        expect(Game.new(double("blah")).total_score(t1)).to eql(20)
      }
    end

    context "When given four turns (with three strikes) with a total score of 76" do
      it {
        f1.instance_variable_set(:@frame, [10, 0])
        f2.instance_variable_set(:@frame, [10, 0])
        f3.instance_variable_set(:@frame, [10, 0])
        f4.instance_variable_set(:@frame, [4, 2])

        expect(Game.new(double("blah")).total_score(t2)).to eql(76)
      }
    end

    context "When given a full set of turns equal to 75" do
      it {
        f1.instance_variable_set(:@frame, [3, 5])
        f2.instance_variable_set(:@frame, [5, 0])
        f3.instance_variable_set(:@frame, [9, 0])
        f4.instance_variable_set(:@frame, [3, 5])
        f5.instance_variable_set(:@frame, [3, 1])
        f6.instance_variable_set(:@frame, [2, 8])
        f7.instance_variable_set(:@frame, [1, 2])
        f8.instance_variable_set(:@frame, [10, 0])
        f9.instance_variable_set(:@frame, [4, 0])
        f10.instance_variable_set(:@frame, [8, 1])

        expect(Game.new(double("blah")).total_score(t3)).to eql(75)
      }
    end
  end

  describe "#running_total" do
    let(:g1) { Game.new(double("blah")) }

    context "When given two turns with a running total of [8,13]" do
      it {
        f1.instance_variable_set(:@frame, [3, 5])
        f2.instance_variable_set(:@frame, [5, 0])
        g1.instance_variable_set(:@turns, [f1, f2])

        expect(g1.running_total).to eq([8, 13])
      }
    end

    context "When given three turns (with three strikes) with a total score of 60" do
      it {
        f1.instance_variable_set(:@frame, [10, 0])
        f2.instance_variable_set(:@frame, [10, 0])
        f3.instance_variable_set(:@frame, [10, 0])
        g1.instance_variable_set(:@turns, [f1,f2,f3])

        expect(g1.running_total).to eq([30, 50, 60])
      }
    end

    context "When given four turns (with three strikes) with a total score of 76" do
      it {
        f1.instance_variable_set(:@frame, [10, 0])
        f2.instance_variable_set(:@frame, [10, 0])
        f3.instance_variable_set(:@frame, [10, 0])
        f4.instance_variable_set(:@frame, [4, 2])
        g1.instance_variable_set(:@turns, t2)

        expect(g1.running_total).to eq([30, 54, 70, 76])
      }
    end
  end
end
