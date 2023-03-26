class MeetingsController < ApplicationController
  def index
    @masterclass = Masterclass.find_by(title: params[:masterclass_title])
    @meetings = @masterclass.meetings
  end

  def new
    @masterclass = Masterclass.find_by(title: params[:masterclass_title])
    @meeting = Meeting.new

    return unless current_user != @masterclass.chef

    flash[:alert] = "Vous n'êtes pas autorisé à créer une nouvelle session pour cette masterclass"
    redirect_back fallback_location: root_path
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.masterclass = Masterclass.find_by(title: params[:masterclass_title])

    if @meeting.save
      flash[:success] = 'Session créée !'
      redirect_to meeting_path(@meeting)
    else
      flash[:alert] = "La session n'a pas pu être créée"
      render :new
    end
  end

  def show
    @meeting = Meeting.find(params[:id])
    @masterclass = @meeting.masterclass
    @chef = @masterclass.chef
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def update; end

  def destroy; end

  private

  def meeting_params
    params.require(:meeting).permit(:start_date, :zip_code, :capacity)
  end
end
