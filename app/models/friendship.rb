class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.db_lookup(user,friend)
    self.where(user:user,friend:friend).exists?
  end
end
