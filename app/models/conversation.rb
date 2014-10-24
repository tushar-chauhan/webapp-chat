class Conversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"

  has_many :messages, dependent: :destroy
  validates_uniqueness_of :user_id, scope: :recipient_id

  scope :involving, -> (user) do
    where("conversations.user_id = ? OR conversations.recipient_id = ?", user.id, user.id)
  end

  scope :between, -> (user_id,recipient_id) do
    where("(conversations.user_id = ? AND conversations.recipient_id =?) OR (conversations.user_id = ? AND conversations.recipient_id =?)", user_id,recipient_id, recipient_id, user_id)
  end
end
