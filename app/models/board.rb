class Board < ApplicationRecord
  belongs_to :user
  # has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy # 追記
  # mount_uploader :board_image, BoardImageUploader

  validates :title, length: { maximum: 255 }, presence: true
  validates :content, length: { maximum: 65535 }, presence: true

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

end
