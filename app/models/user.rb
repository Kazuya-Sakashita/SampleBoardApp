class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boards, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarks_boards, through: :bookmarks, source: :board

  # userのidを入れて、bookmarksメソッドを入れて、それぞれのboardを出す
  # 下記の記述はuser.bookmarks.map(&:board)これをしているのと一緒

  # 引数に渡されたものが、userのものであるか？
  # def own?(object)
  #   id == object.user_id
  # end
  def own?(object)
    object.user_id == self.id  #selfは省略可
  end

  # お気に入りにしている掲示板を取得する
  def bookmark(board)
    bookmarks_boards << board
  end
  # お気に入りを外す
  def unbookmark(board)
    bookmarks_boards.destroy(board)
  end

  # お気に入り登録しているか判定するメソッド
  def bookmark?(board)
    # userを起点にしてSQLを走らせてしまっているためレコードを取得する時に毎回SQLが走ってしまう。
    bookmarks_boards.include?(board)
    #Bookmark.where(user_id: id, board_id: board.id).exist?と同じ
    #
    # boardを起点にしてSQLが走り、検索をかける。無駄なSQLが走らない。
    # bookmarks_boards.pluck(:user_id).include?(id)
  end

end
