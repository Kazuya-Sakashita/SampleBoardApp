class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookmarks_boards, through: :bookmarks, source: :board
  has_many :bookmarks, dependent: :destroy
  # お気に入りにしている掲示板を取得する
  def bookmark(board)
    bookmarks_boards << board
  end
  # お気に入りを外す
  def unbookmark(board)
    bookmarks_boards.delete(board)
  end

  # お気に入り登録しているか判定するメソッド
  def bookmark?(board)
    bookmarks_boards.include?(board)
  end

end
