# frozen_string_literal: true

describe Services::Oauth::Install do
  subject { described_class.new }
  describe '#call' do
    let(:subject_call) { subject.call }
    let(:consent_page_uri) do
      "https://dashboard-v2.aircall.io/oauth/authorize?client_id=foo&redirect_uri=https://test.com&response_type=code&scope=public_api"
    end

    it 'returns Aircall consent page URI' do
      expect(subject_call).to eq(consent_page_uri)
    end
  end
end
