class Bookmark < ApplicationRecord
    store :meta_data, accessors: [ :description, :image, :title  ], coder: JSON
    has_one_attached :thumbnail
    belongs_to :user

    def self.search(str)
        where('url like ?', "%#{str}%")
    end
end
