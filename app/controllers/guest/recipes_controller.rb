class Guest::RecipesController < ApplicationController
  def index
    find_past_meetings
    @recipes = @meetings.each_with_object([]) do |meeting, recipes|
      meeting.masterclass.recipes.each { |recipe| recipes << recipe }
    end
  end

  private
  
  def find_past_meetings
    @meetings = current_user.meetings.each_with_object([]) { |meeting, past_meetings| past_meetings << meeting if meeting.start_date < DateTime.now }
  end
end
