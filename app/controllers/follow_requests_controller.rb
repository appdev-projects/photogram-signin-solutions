class FollowRequestsController < ApplicationController
  def save_new_row
    follow_req = FollowRequest.new
    follow_req.sender_id = params.fetch("sender_id")
    follow_req.recipient_id = params.fetch("recipient_id")
    follow_req.status = "pending"

    follow_req.save

    redirect_to("/users/" + follow_req.sender_id.to_s + "/following")
  end

  def save_old_row
    follow_req = FollowRequest.where({ :id => params.fetch("modify_id") }).at(0)
    follow_req.status = params.fetch("new_status")

    follow_req.save

    redirect_to("/users/" + follow_req.recipient_id.to_s + "/followers")
  end
end
