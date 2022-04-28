# frozen_string_literal: true

# app/services/application_service.rb
class ApplicationService
  attr_accessor :success, :data, :messages

  def self.call(*args, &block)
    new(*args, &block).call
  end

  def call
    @success = false
    @message = ''
    @data = {}
  end

  def success?
    Struct.new(:success?, :messages, :data).new(@success, @messages, @data)
  end

  def fail_process(message)
    @success = false
    @messages = message
    puts " ++++++++++++#{message}"
  end
end
