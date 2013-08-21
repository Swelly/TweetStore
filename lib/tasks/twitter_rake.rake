namespace :twitter_rake do
  desc "Rake twitter using TweetStream"
  task :stream => :environment do

    TweetStream.configure do |config|
      config.consumer_key       = ENV['CONSUMER_KEY']
      config.consumer_secret    = ENV['CONSUMER_SECRET']
      config.oauth_token        = ENV['ACCESS_TOKEN']
      config.oauth_token_secret = ENV['ACCESS_TOKEN_SECRET']
      config.auth_method        = :oauth
    end

    puts "Preparing to stream"

    # Setting the Client before the stream
    client = TweetStream::Client
    puts client

    ## Running the rake to and Tweets ##
    client.new.sample do |status|
      Tweet.create(status.to_hash)
    end

    client.on_limit do |skip_count|
      # do something
      puts "limited"
    end

    client.on_error do |err|
      puts err
    end

    client.on_enhance_your_calm do
      # do something
      puts "enhance calm"
    end

    client.control.info do |info|
      # do something
      puts info
    end

  end

end
