class MeetingsController < ApplicationController
  def index
    @masterclass = Masterclass.find_by(title: params[:masterclass_title])
    @meetings = @masterclass.meetings
  end

  def show; end
end
