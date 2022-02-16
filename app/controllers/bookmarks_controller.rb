class BookmarksController < ApplicationController
    before_action :authenticate_user!
    
    def index 
        @tabs = current_user.bookmarks.search(params[:search]).order(:id).page(params[:page]).per 11
    end

    def create
        @bookmark = current_user.bookmarks.new(params.require(:bookmarks).permit(:url, :image))
        @bookmark.save
        MicrolinkImageAttacherJob.perform_now(@bookmark)
        redirect_to root_path
    end
end
