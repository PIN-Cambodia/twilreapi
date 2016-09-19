class Api::Admin::PhoneCallsController < Api::Admin::BaseController
  self.responder = Api::Admin::PhoneCallsResponder

  private

  def permission_name
    :manage_inbound_phone_calls
  end

  def association_chain
    PhoneCall
  end

  def save_resource
    resource.initiate_inbound_call
  end

  def permitted_params
    params.permit("To", "From", "SomlengSid")
  end
end