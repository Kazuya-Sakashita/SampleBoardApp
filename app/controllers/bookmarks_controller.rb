class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    # board = Board.find(params[:board_id])
    board = Board.find(params[:board_id])
    current_user.bookmark(board)
    redirect_back fallback_location: root_path, success: 'ブックマークしました'
  end

  def destroy
    # board = current_user.bookmarks.find_by(params[:id]).board
    board = current_user.bookmarks.find(params[:board_id]).board
    current_user.unbookmark(board)
    redirect_back fallback_location: root_path, success: 'ブックマークを外しました'
  end
end