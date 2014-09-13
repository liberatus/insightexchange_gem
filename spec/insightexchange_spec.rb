require 'spec_helper'

describe InsightExchange do
  let(:api_token) { 'abc123' }
  let(:exchange) { InsightExchange.new(api_token) }

  describe 'reading options from ENV variables' do
    before { ENV['INSIGHT_EXCHANGE_TOKEN'] = api_token }
    after { ENV['INSIGHT_EXCHANGE_TOKEN'] = nil }

    it 'reads INSIGHT_EXCHANGE_TOKEN' do
      client = InsightExchange.new
      expect(client.api_token).to eql(api_token)
    end
  end

  describe '#publish' do
    let(:request_body) { 'api_token=abc123&insight[email]=this_email%40that_address.com&insight[name]=CreatedPopularPoem' }

    describe 'when valid inputs' do
      it 'POSTS to InsightExchange api' do
        stub_request(:post, 'https://secure.insightexchange.co/sellers/api/insights.json').
            with(:body => request_body).
            to_return(:status => 200, :body => "", :headers => {})

        exchange.publish 'this_email@that_address.com', 'CreatedPopularPoem'

        assert_requested(:post, 'https://secure.insightexchange.co/sellers/api/insights.json') do
          request_body
        end
      end

      it 'POSTS arbitrary data' do
        request_body = 'api_token=abc123&insight[email]=this_email%40that_address.com&insight[name]=CreatedPopularPoem&insight[data][arbitrary]=data'

        stub_request(:post, 'https://secure.insightexchange.co/sellers/api/insights.json').
            with(:body => request_body).
            to_return(:status => 200, :body => "", :headers => {})

        exchange.publish 'this_email@that_address.com', 'CreatedPopularPoem', arbitrary: 'data'

        assert_requested(:post, 'https://secure.insightexchange.co/sellers/api/insights.json') do
          request_body
        end
      end
    end

    describe 'when invalid inputs' do

      it 'raises when missing api_token' do
        expect {
          InsightExchange.new.publish 'this_email@that_address.com', 'CreatedPopularPoem'
        }.to raise_error(InsightExchange::MissingTokenError)
      end

      it 'raises when missing email_address' do
        expect {
          exchange.publish '', 'SomeInsight'
        }.to raise_error(ArgumentError)
      end

      it 'raises when missing insight_name' do
        expect {
          exchange.publish 'this_email@that_address.com', ''
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#identify' do

    describe 'when valid inputs' do
      let(:request_body) { 'api_token=abc123&user[email]=this_email%40that_address.com' }

      it 'POSTS to InsightExchange api' do
        stub_request(:post, 'https://secure.insightexchange.co/sellers/api/users.json').
            with(:body => request_body).
            to_return(:status => 200, :body => "", :headers => {})

        exchange.identify 'this_email@that_address.com'

        assert_requested(:post, 'https://secure.insightexchange.co/sellers/api/users.json') do
          request_body
        end
      end
    end

    describe 'when invalid inputs' do

      it 'raises when missing api_token' do
        expect {
          InsightExchange.new.identify 'this_email@that_address.com'
        }.to raise_error(InsightExchange::MissingTokenError)
      end

      it 'raises when missing email_address' do
        expect {
          exchange.identify ''
        }.to raise_error(ArgumentError)
      end
    end
  end
end
