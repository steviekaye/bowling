#require './lib/frame.rb'
require "frame"

describe Frame do
  let(:f1) { Frame.new() }

  let(:f2) { Frame.new() }

  describe "#strike?" do
    context "When given a strike" do
      it {
        f1.instance_variable_set(:@frame, [10, 0])
        expect(f1.strike?).to be true
      }
    end

    context "When given a non-strike" do
      it {
        f2.instance_variable_set(:@frame, [8, 2])
        expect(f2.strike?).to be false
      }
    end
  end

  describe "#spare?" do
    context "When given a spare" do
      it {
        f1.instance_variable_set(:@frame, [8, 2])
        expect(f1.spare?).to be true
      }
    end

    context "When given a non-spare" do
      it {
        f2.instance_variable_set(:@frame, [8, 1])
        expect(f2.strike?).to be false
      }
    end
  end

  describe "#get_first" do
    context "When getting the first ball of frame [8,2]" do
      it {
        f1.instance_variable_set(:@frame, [8, 2])
        expect(f1.get_first).to eql(8)
      }
    end
  end

  describe "#get_second" do
    context "When getting the second ball of frame [8,2]" do
      it {
        f1.instance_variable_set(:@frame, [8, 2])
        expect(f1.get_second).to eql(2)
      }
    end
  end
end
