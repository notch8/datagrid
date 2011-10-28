describe Datagrid::Drivers::Mongoid do

  describe ".match?" do
    
    subject { described_class }

    it {should be_match(MongoidEntry)}
    it {should be_match(MongoidEntry.scoped)}
    it {should_not be_match(Entry.scoped)}

  end
  describe "api" do

    subject do
      MongoidGrid.new(
        defined?(_attributes) ? _attributes : {}
      )
    end

    let!(:first) do
      MongoidEntry.create!(
        :group_id => 2,
        :name => "Main First",
        :disabled => false
      )
    end
    let!(:second) do
      MongoidEntry.create!(
        :group_id => 3,
        :name => "Main Second",
        :disabled => true
      )
    end


    its(:assets) {should include(first, second)}

    its(:"assets.size") {should == 2}
    its(:rows) {should == [["Main First", 2, false], ["Main Second", 3, true]]}
    its(:header) {should ==[ "Name", "Group", "Disabled"]}

    its(:data) {should == [[ "Name", "Group", "Disabled"], ["Main First", 2, false], ["Main Second", 3, true]]}


    describe "when some filters specified" do
      let(:_attributes) { {:group_id => 2} }
      its(:assets) {should include(first)}
      its(:assets) {should_not include(second)}
    end

    describe "when reverse ordering is specified" do
      let(:_attributes) { {:order => :name, :descending => true} }
      its(:rows) {should == [["Main Second", 3, true], ["Main First", 2, false]]}
    end
  end
end