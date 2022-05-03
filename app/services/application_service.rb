# frozen_string_literal: true

# app/services/application_service.rb
class ApplicationService
  attr_accessor :success, :data, :messages, :file_manager

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
  end

  def init_file(path_file)
    @file_manager = FileManager::Read.call(path_file)
  end

  def read_file
    raise(StandardError, @file_manager.messages) unless @file_manager.success?

    @file_manager.data
  end
end
