require 'rails_helper'

RSpec.describe Friend, type: :model do

  let(:friend) { build(:friend) }

  context 'Associations' do
    it 'belongs_to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs_to friend' do
      association = described_class.reflect_on_association(:friend)
      expect(association.macro).to eq :belongs_to
      expect(association.options[:class_name]).to eq 'User'
    end
  end

  context 'Validations' do
    it 'is valid to create a new friend' do
      expect(friend).to be_valid
    end

    it 'is not valid with the same user' do
      friend = create(:friend)
      duplicate_friend = friend.dup
      expect(duplicate_friend).not_to be_valid
    end
  end

  context 'Methods' do
    it 'finds by users' do
      user1 = create(:user)
      user2 = create(:user)
      friend = create(:friend, user_id: user1.id, friend_id: user2.id)
      expect(Friend.find_by_users(user1.id, user2.id)).to eq friend
    end
  end

end