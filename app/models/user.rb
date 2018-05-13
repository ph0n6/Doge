class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, dependent: :destroy
  
  # Association for Friends
  has_many :friends
  has_many :all_received_friend_requests,  
  class_name: "Friend", 
  foreign_key: "friend_id"

  has_many :accepted_sent_friend_requests, -> { where(friends: { accepted: true}) }, 
            through: :friends, 
            source: :friend

  has_many :accepted_received_friend_requests, -> { where(friends: { accepted: true}) }, 
            through: :all_received_friend_requests, 
            source: :user

  has_many :pending_received_friend_requests, ->  { where(friends: { accepted: false}) }, 
            through: :all_received_friend_requests, 
            source: :user
  
  
  # gets all your friends
  def all_active_friends
    accepted_sent_friend_requests | accepted_received_friend_requests
  end
  
  # gets your pending sent and received friends
  def pending_friends
    pending_sent_friend_requests | pending_received_friend_requests
  end
  
  # gets a friend record
  def friend(friend)
  Friend.where(user_id: self.id, friend_id: friend.id)[0]

end
