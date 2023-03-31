class Chef::MeetingsController < ApplicationController
  def new
    @masterclass = params[:title]
    @meeting = Meeting.new
  end
end
