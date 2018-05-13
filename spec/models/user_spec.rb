require 'rails_helper'

RSpec.describe User, type: :model do

  context 'Associations' do
    # Post spec
    it 'has_many posts' do
      association = described_class.reflect_on_association(:posts)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end

    # Friend Spec  
    it 'has_many friends' do
      association = described_class.reflect_on_association(:friends)
      expect(association.macro).to eq :has_many
    end
  
    it 'has_many all_received_friend_requests' do
      association = described_class.reflect_on_association(:all_received_friend_requests)
      expect(association.macro).to eq :has_many
      expect(association.options[:class_name]).to eq 'friend'
      expect(association.options[:foreign_key]).to eq 'friend_id'
    end
  
    it 'has_many accepted_sent_friend_requests' do
      association = described_class.reflect_on_association(:accepted_sent_friend_requests)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :friends
      expect(association.options[:source]).to eq :friend
    end
  
    it 'has_many accepted_received_friend_requests' do
      association = described_class.reflect_on_association(:accepted_received_friend_requests)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :all_received_friend_requests
      expect(association.options[:source]).to eq :user
    end
  
    it 'has_many pending_sent_friend_requests' do
      association = described_class.reflect_on_association(:pending_sent_friend_requests)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :friends
      expect(association.options[:source]).to eq :friend
    end
  
    it 'has_many pending_received_friend_requests' do
      association = described_class.reflect_on_association(:pending_received_friend_requests)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :all_received_friend_requests
      expect(association.options[:source]).to eq :user
    end
  end
  
  context 'Methods' do
    let(:user) { build(:user) }
    let(:friend_requests) do
      @user = create(:user)
      create_list(:friend, 2)
      create_list(:friend, 2, accepted: true)
      create(:friend, user_id: @user.id)
      create(:friend, user_id: @user.id, accepted: true)
      create(:friend, friend_id: @user.id)
      create(:friend, friend_id: @user.id, accepted: true)
    end
  
    it 'accepted_sent_friend_requests gets only accepted requests' do
      friend_requests
      expect(@user.accepted_sent_friend_requests.count).to eq 1
    end
  
    it 'accepted_received_friend_requests gets only accepted requests' do
      friend_requests
      expect(@user.accepted_received_friend_requests.count).to eq 1
    end
  
    it 'pending_sent_friend_requests gets only unaccepted requests' do
      friend_requests
      expect(@user.pending_sent_friend_requests.count).to eq 1
    end
  
    it 'pending_received_friend_requests gets only unaccepted requests' do
      friend_requests
      expect(@user.pending_received_friend_requests.count).to eq 1
  end


  end
end