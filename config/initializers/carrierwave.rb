CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'                        # required
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     "AKIAJ3WUKF3SSH2ZLENQ", #ENV['S3_KEY'],                        # required
      aws_secret_access_key: "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",
      region:                'us-west-2'#ENV['S3_SECRET'],                        # required
    }
    config.fog_directory  = "tortillamaps"#ENV['S3_BUCKET_NAME']                          # required
end