require 'rails_helper'

describe "'/api/2010-04-01/Accounts/{AccountSid}/Calls'" do
  # https://www.twilio.com/docs/api/rest/making-calls
  describe "POST '/'" do
    let(:params) { {} }

    before do
      do_request(:post, api_twilio_account_calls_path(account_sid), params)
    end

    context "unauthorized request" do
      context "wrong AuthToken" do
        let(:http_basic_auth_password) { "wrong" }
        it { assert_unauthorized! }
      end

      context "wrong AccountSid" do
        let(:account_sid) { "wrong" }
        it { assert_not_found! }
      end

      context "no authorization" do
        let(:authorization_headers) { {} }

        def assert_unauthorized!
          super
          expect(response.headers["WWW-Authenticate"]).to eq("Basic realm=\"Twilio API\"")
        end

        it { assert_unauthorized! }
      end
    end

    context "valid request" do
      let(:params) {
        {
          "Url"=>"https://rapidpro.ngrok.com/handle/33/",
          "Method"=>"GET",
          "To"=>"+855715100860",
          "From"=>"2442",
          "StatusCallback"=>"https://rapidpro.ngrok.com/handle/33/",
          "StatusCallbackMethod"=>"GET",
        }
      }

      let(:phone_call) { account.phone_calls.last! }
      let(:enqueued_job) { enqueued_jobs.first }

      def assert_valid_request!
        expect(response.code).to eq("201")
        expect(response["Location"]).to eq(api_twilio_account_call_url(account, phone_call))
        expect(response.body).to eq(phone_call.to_json)
        expect(phone_call.status_callback_url).to be_present
        expect(enqueued_job[:args]).to match_array([phone_call.id])
      end

      it { assert_valid_request! }
    end

    context "invalid request" do
      it { assert_invalid_request! }
    end
  end

  # https://www.twilio.com/docs/api/rest/call#instance-get
  describe "GET '/{CallSid}'" do
    let(:phone_call) { create(:phone_call, :account => account) }

    before do
      do_request(:get, api_twilio_account_call_path(account_sid, phone_call))
    end

    context "valid request" do
      def assert_valid_request!
        expect(response.code).to eq("200")
        expect(response.body).to eq(phone_call.to_json)
      end

      it { assert_valid_request! }
    end
  end
end
