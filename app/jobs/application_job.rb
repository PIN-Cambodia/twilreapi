class ApplicationJob < ActiveJob::Base
  def self.aws_sqs_queue_name
    aws_sqs_queue_url.split("/").last
  end

  def self.aws_sqs_queue_url
    AppConfig.fetch(:"#{to_s.underscore}_queue_url") { AppConfig.fetch(:default_queue_url) }
  end

  queue_as(aws_sqs_queue_name)
end
