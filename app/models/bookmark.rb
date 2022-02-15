class Bookmark < ApplicationRecord
    store :meta_data, accessors: [ :description, :image, :title  ], coder: JSON
    has_one_attached :thumbnail
    belongs_to :user
    paginates_per 11

    def self.search(str)
        where('url like ?', "%#{str}%")
    end
end
