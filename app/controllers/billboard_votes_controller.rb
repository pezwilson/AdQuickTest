class BillboardVotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_billboard

  def create
    existing_vote = BillboardVote.where(billboard_id: @billboard.id, user_id: current_user.id).first
    if existing_vote && existing_vote.direction == params[:direction]
      redirect_to billboards_path, notice: "You can't vote #{params[:direction]} twice for the same billboard! :)"
    else
      params[:billboard_vote] = {}
      params[:billboard_vote][:user_id] = current_user.id
      params[:billboard_vote][:billboard_id] = @billboard.id
      params[:billboard_vote][:direction] = params[:direction]
      vote = BillboardVote.new(billboard_vote_params)
      if vote.save
        if vote.direction == 'up'
          @billboard.upvotes += 1
          @billboard.downvotes -= 1 if existing_vote
        else
          @billboard.downvotes += 1
          @billboard.upvotes -= 1 if existing_vote
        end
        @billboard.score = @billboard.upvotes - @billboard.downvotes
        @billboard.save
        redirect_to billboards_path, notice: "Thanks for voting!"
      else
        redirect_to billboards_path, notice: "System error! Please try voting again"
      end
    end
  end

  private

  def billboard_vote_params
    params.required(:billboard_vote).permit(:billboard_id, :user_id, :direction)
  end

  def set_billboard
    begin
      @billboard = Billboard.find(params[:billboard_id])
    rescue ActiveRecord::RecordNotFound
      render json: nil, status: :unprocessable_entity
    end
  end

end