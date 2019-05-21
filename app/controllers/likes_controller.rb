class LikesController < ApplicationController
  def save_new_row
    like = Like.new
    like.photo_id = params.fetch("picture_id")
    like.fan_id = params.fetch("person_id")

    like.save

    redirect_to("/photos/" + like.photo_id.to_s)
  end
end
