class TwitterController < ApplicationController
  def index
    @twitter ||= MyTwitter.new
    p @twitter.tag
  end

  def tweet
    @twitter ||= MyTwitter.new
    if @twitter && params[:tag]
      @twitter.tag = params[:tag]
      tag = @twitter.tag.slice(0) == '#' ?  @twitter.tag.slice(1, 999) : @twitter.tag
      @twitter.tweet = @twitter.client.search("##{tag}", lang: "ja", result_type: 'recent', count: params[:limit]).map do |tweet|
        {
          icon: tweet.user.profile_image_url,
          name: tweet.user.name,
          text: tweet.text,
          rt: tweet.retweet_count
        }
      end.sort do |a, b|
        b[:rt] <=> a[:rt]
      end
    end
    render action: 'index'
  rescue => e
    logger.error e.message
    flash[:error] = "エラーが起きました[#{e.message}]"
    render action: 'index'
  end
end
