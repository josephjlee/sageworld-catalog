RSpec.describe SageWorld do
  it "has a version number" do
    expect(SageWorld::VERSION).not_to be nil
  end

  it 'has version equal to 0.0.1' do
    expect(SageWorld::VERSION).to eq("0.1.0")
  end
end
