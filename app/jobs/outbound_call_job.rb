class OutboundCallJob < ActiveJob::Base
  def perform(phone_call_id)
    PhoneCall.find(phone_call_id).initiate_outbound_call!
  end
end
