class PicturesController < ApplicationController
  def recent
    @photos = Photo.all.order({ :created_at => :desc }).limit(25)

    render("pic_templates/time_list.html.erb")
  end

  def most_liked
    @photos = Photo.all.order({ :likes_count => :desc }).limit(25)

    render("pic_templates/liked_list.html.erb")
  end

  def show_details
    photo_id = params.fetch("some_id")

    @pic = Photo.where({ :id => photo_id }).at(0)

    render("pic_templates/details.html.erb")
  end

  def blank_form
    render("pic_templates/new_record_form.html.erb")
  end

  def save_new_row
    picture = Photo.new
    picture.image = params.fetch("pic_image")
    picture.caption = params.fetch("pic_caption")
    picture.owner_id = params.fetch("poster_id")

    picture.save

    redirect_to("/recent")
  end
end
