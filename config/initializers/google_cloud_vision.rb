require "google/cloud/vision"

Google::Cloud::Vision.configure do |config|
  config.credentials = ENV["GOOGLE_CLOUD_API_KEY"]
end
