# frozen_string_literal: true

require 'rails_helper'
RSpec.describe(FileManager::Read, type: :service) do
  describe '#call' do
    let(:path_file) { Files::OK }
    let(:file_manager) { FileManager::Read.call(path_file) }
    let(:file_not_found) { Files::NOT_FOUND }
    let(:file_manager_fail) { FileManager::Read.call(file_not_found) }
    let(:file_empty) { Files::EMPTY }
    let(:file_manager_empty) { FileManager::Read.call(file_empty) }

    context 'when success' do
      it 'read file' do
        expect(file_manager.success?).to be(true)
      end
      it 'data is an string' do
        expect(file_manager.data).to be_an_instance_of(String)
      end
      it 'is empty file' do
        expect(file_manager_empty.data.size).to be(0)
      end
    end
    context 'when fail' do
      it 'trying read file' do
        expect(file_manager_fail.success?).to be(false)
      end
    end
  end
end
