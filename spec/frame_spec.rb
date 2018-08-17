#require './lib/frame.rb'
require "frame"

describe Frame do
  describe "#strike?" do
    context "When given a strike" do
      let(:frame) { Frame.new([10, 0]) }
      it {
        expect(frame.strike?).to be true
      }
    end

    context "When given a non-strike" do
      let(:frame) { Frame.new([8, 2]) }
      it {
        expect(frame.strike?).to be false
      }
    end
  end

  describe "#spare?" do
    context "When given a spare" do
      let(:frame) { Frame.new([8, 2]) }
      it {
        expect(frame.spare?).to be true
      }
    end

    context "When given a non-spare" do
      let(:frame) { Frame.new([8, 1]) }
      it {
        expect(frame.spare?).to be false
      }
    end
  end

  describe "#get_first" do
    context "When getting the first ball of frame [8,2]" do
      let(:frame) { Frame.new([8, 2]) }
      it {
        expect(frame.get_first).to eql(8)
      }
    end
  end

  describe "#get_second" do
    context "When getting the second ball of frame [8,2]" do
      let(:frame) { Frame.new([8, 2]) }
      it {
        expect(frame.get_second).to eql(2)
      }
    end
  end

  describe "#score_frame" do
    context "When given a frame of size two ([7,2])" do
      let(:frame) { Frame.new([7, 2]) }
      it {
        expect(frame.score_frame).to eql(9)
      }
    end

    context "When given a frame of size three ([10,4,3])" do
      let(:frame) { Frame.new([10, 4, 3]) }
      it {
        expect(frame.score_frame).to eql(17)
      }
    end
  end
end
