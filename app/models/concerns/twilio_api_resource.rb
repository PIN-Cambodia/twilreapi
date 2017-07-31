module TwilioApiResource
  extend ActiveSupport::Concern

  include TwilioTimestamps
  include TwilioJson

  included do
    belongs_to :account

    alias_attribute :sid, :id
    delegate :sid, :to => :account, :prefix => true
  end
end
