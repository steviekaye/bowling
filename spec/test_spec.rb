class MyClass
  def addFive(num)
    num + 5
  end
end

describe MyClass do
  describe "#addFive" do
    context "When given a number" do
      let(:result) { MyClass.new.addFive(3) }
      it { expect(result).to eql(8) }
    end

    context "When given a string" do
      let(:result) { MyClass.new.addFive("potato") }
      it { expect { result }.to raise_error(TypeError) }
    end
  end
end
