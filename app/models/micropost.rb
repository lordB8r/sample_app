class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user

  validates :content, :presence => true, :length => {:maximum => 140}
  validates :user_id, :presence => true

  default_scope :order => 'microposts.created_at DESC'

  # return microposts from the users being followed by the given user
  scope :from_users_followed_by, lambda { |user| followed_by(user)}

  def self.from_users_followed_by(user)
    followed_ids = user.following.map(&:id).join(", ")
    where("user_id IN (#{followed_ids}) or user_id  = ?", user)
  end

  private
    # return an sql condition for users followed by the given user.
    # we include the user's own id as well
    def self.followed_by(user)
      followed_ids = %(SELECT followed_id FROM relationships
                        WHERE follower_id = :user_id)
      where("user_id IN (#{followed_ids}) OR user_id = :user_id", {:user_id => user})
      #followed_ids = user.following.map(&:id).join(", ")
      #where("user_id IN (#{followed_ids}) OR user_id = :user_id", {:user_id => user})
    end

end
