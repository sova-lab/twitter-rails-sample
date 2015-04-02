class MyTwitter
  include ActiveModel::Model

  attr_accessor :tag, :limit, :tweet

  validates :tag, presence: true

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = "your consumer_key"
      config.consumer_secret = "your consumer_secret"
      config.access_token = 'your access_token'
      config.access_token_secret = 'your access_token_secret'
    end
  end
end
