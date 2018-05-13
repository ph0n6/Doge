class FriendsController < ApplicationController

    def create
        @friend = current_user.friends.create(friend_id: params[:friend_id])
        respond_ok
      end
    
      def update
        @friend = friend.find_by_users(params[:id], current_user.id)
        @friend.update(accepted: true)
        respond_ok
      end
    
      def destroy
        @friend = Friend.find_by_users(params[:id], current_user.id)
        @friend.destroy
        respond_ok
      end
    
      private
    
      def respond_ok
        respond_to do |format|
          format.json  { head :ok } 
        end
      end
    
end
