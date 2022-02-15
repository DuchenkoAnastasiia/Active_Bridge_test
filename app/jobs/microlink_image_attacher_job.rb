require "down"

class MicrolinkImageAttacherJob < ApplicationJob
  queue_as :default
  discard_on Down::InvalidUrl

  def perform(bookmark)
    if bookmark.image.present?
      tempfile = Down.download(bookmark.image)
      bookmark.thumbnail.attach(io: tempfile, filename: tempfile.original_filename) 
    end
  end
end
