
class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    client = Google::Cloud::Vision::V1::ImageAnnotator::Client.new
    image = { content: File.read('app/assets/images/test.png') }
    @response = client.text_detection(image: image)
  end
end
