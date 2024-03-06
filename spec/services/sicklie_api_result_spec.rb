# frozen_string_literal: true

require "rails_helper"

RSpec.describe SicklieApiResult do
  let(:subject) {described_class.new(api_response)}

  context 'when result is a String' do
    let(:api_response) { 'Internal Server Error' }

    describe '#success?' do
      it 'its false' do
        expect(subject.success?).to be_falsey
      end
    end

    describe '#error_message' do
      it 'contains the error message' do
        expect(subject.error_message).to eq api_response
      end
    end
  end

  context 'when result is a Hash' do
    context 'when result is successful' do
    let(:api_response) { { status_code: "SUCCESS" } }

      describe '#success?' do
        it 'its true' do
          expect(subject.success?).to be_truthy
        end
      end

      describe '#error_message' do
        it 'is empty' do
          expect(subject.error_message).to be_nil
        end
      end
    end

    context 'when result is NOT successful' do
      let(:api_response) { { status_code: "FIELD_ERROR", field: "last_name", message: "Sorry, we don't like this last name right now" } }

      describe '#success?' do
        it 'its false' do
          expect(subject.success?).to be_falsey
        end
      end

      describe '#error_message' do
        it 'contains the error message' do
          expect(subject.error_message).to include(api_response[:message])
        end
      end
    end
  end

  context 'when result is an Array' do
    let(:api_response) { [{ status_code: "FIELD_ERROR", field: "last_name", message: "Sorry, we don't like this last name right now" }] }

    describe '#success?' do
      it 'its false' do
        expect(subject.success?).to be_falsey
      end
    end

    describe '#error_message' do
      it 'contains the error message' do
        expect(subject.error_message).to include(api_response.first[:message])
      end
    end
  end
end
