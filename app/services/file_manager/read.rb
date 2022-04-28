# frozen_string_literal: true

# Service to read local files
module FileManager
  class Read < ApplicationService
    def initialize(path_file)
      @path_file = full_path(path_file)
    end

    attr_accessor :path_file, :file

    def call
      super
      begin
        read
      rescue ::StandardError => error
        fail_process(error.message)
      end
      success?
    end

    private

    def read
      @file = File.open(@path_file, 'r')
      @data = @file.read
      @success = true
      @file.close
    end

    def full_path(path)
      Rails.root.join(path)
    end
  end
end
