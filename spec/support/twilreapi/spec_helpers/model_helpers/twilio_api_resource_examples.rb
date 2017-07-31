shared_examples_for "twilio_api_resource" do
  include_examples "twilio_timestamps"
  include_examples "twilio_json"

  describe "associations" do
    it { is_expected.to belong_to(:account) }
  end
end
