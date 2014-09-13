require 'insightexchange/version'
require 'httparty'

class InsightExchange
  include ::HTTParty
  base_uri 'https://secure.insightexchange.co/sellers/api'
  format :json

  class MissingTokenError < RuntimeError; end

  attr_accessor :api_token

  def initialize(api_token = ENV['INSIGHT_EXCHANGE_TOKEN'])
    self.api_token = api_token
  end

  def publish(email_address, insight_name, data = {})
    ensure_api_token!
    ensure_insight_name!(insight_name)
    ensure_email_address!(email_address)

    self.class.post("/insights.json", body: {
        api_token: api_token,
        insight: {
          email: email_address,
          name: insight_name,
          data: data
        }
    })
  end

  def identify(email_address)
    ensure_api_token!
    ensure_email_address!(email_address)

    self.class.post("/users.json", body: {
        api_token: api_token,
        user: {
            email: email_address
        }
    })
  end

  private

    def ensure_api_token!
      if api_token.nil? || api_token.length == 0
        raise MissingTokenError.new('No API token was provided for InsightExchange, either through an ENV variable or the client initializer.')
      end
    end

    def ensure_email_address!(email_address)
      raise ArgumentError.new('missing email address') unless email_address && email_address.length > 1
    end

    def ensure_insight_name!(insight_name)
      raise ArgumentError.new('missing insight name') unless insight_name && insight_name.length > 1
    end
end
