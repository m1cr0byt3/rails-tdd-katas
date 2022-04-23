# frozen_string_literal: true

# app/services/application_service.rb
class ApplicationService
  attr_accessor :success, :data, :messages

  def self.call(*args, &block)
    new(*args, &block).call
  end

  def success?
    Struct.new(:success?, :errors, :data).new(success, messages, data)
  end
end
