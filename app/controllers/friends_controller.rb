class FriendsController < ApplicationController
    def index
        auth = FbGraph2::Auth.new("4836415126440760", "2f39c1acf3697d1c173642fc05eb5852")
        fb_user = FbGraph2::User.new(current_user.uid).authenticate(auth.access_token!)
        fb_friends = fb_user.fetch.friends
        @friends = User.where(uid: fb_friends.map(&:id))
    end

    def show
        @tabs = User.find(params[:id]).bookmarks.search(params[:search]).order(:id).page params[:page]
    end
end
