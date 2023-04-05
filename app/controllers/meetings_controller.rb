class MeetingsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :authenticate_chef!, except: %i[index show]

  def index
    @masterclass = Masterclass.find_by(title: params[:masterclass_title])
    @meetings = @masterclass.meetings.order(:start_date)
  end

  def new
    @masterclass = Masterclass.find_by(title: params[:masterclass_title])
    @meeting = Meeting.new(masterclass: @masterclass)
    authenticate_owner_chef!(@meeting)
  end

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.masterclass = Masterclass.find_by(title: params[:masterclass_title])

    if @meeting.save
      flash[:success] = 'Session créée !'
      redirect_to meeting_path(@meeting)
    else
      flash[:danger] = "La session n'a pas pu être créée"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @meeting = Meeting.find(params[:id])
    @masterclass = @meeting.masterclass
    @chef = @meeting.chef
  end

  def edit
    @meeting = Meeting.find(params[:id])
    authenticate_owner_chef!(@meeting)
  end

  def update
    @meeting = Meeting.find(params[:id])
    authenticate_owner_chef!(@meeting)

    if @meeting.update(meeting_params)
      flash[:success] = 'Session mise à jour !'
      redirect_to meeting_path(@meeting)
    else
      flash[:danger] = "La session n'a pas pu être modifiée !"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @meeting = Meeting.find(params[:id])
    authenticate_owner_chef!(@meeting)
    @masterclass = @meeting.masterclass
    @meeting.destroy
    flash[:success] = 'Session supprimée'
    redirect_to chef_masterclass_path(current_user, @masterclass)
  end

  private

  def meeting_params
    params.require(:meeting).permit(:start_date, :zip_code, :capacity)
  end
end
