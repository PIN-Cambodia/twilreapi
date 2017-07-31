shared_examples_for "phone_call_event" do
  describe "associations" do
    it { is_expected.to belong_to(:phone_call) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:type) }
  end

  describe "factory" do
    subject { create(factory) }
    it { is_expected.to be_valid }
  end

  describe "#to_json" do
    subject { create(factory) }
    let(:json) { JSON.parse(subject.to_json) }

    let(:asserted_json_keys) { ["created_at", "id", "params", "updated_at", "phone_call"] }

    def assert_json!
      expect(json.keys).to match_array(asserted_json_keys)
    end

    it { assert_json! }
  end

  describe "events" do
    subject { create(factory, *traits) }
    let(:traits) { [] }

    def asserted_broadcast_event_name(event_type)
      [asserted_phone_call_event_name, event_type].join("_")
    end

    context "create" do
      it("should broadcast") {
        assert_broadcasted!(asserted_broadcast_event_name(:created)) { subject }
      }
    end
  end
end
