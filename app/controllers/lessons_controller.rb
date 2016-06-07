class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = Lesson.where(course_id: params["course"],group_id: params["group"])
    @students = Group.find(params["group"]).students
    #@stat = Group.find(params["group"]).lessons.find(:lesson_id).results.group(:mark).count
    Lesson.add_lessons(params["course"],params["group"])
    static
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

def static
#   data = [[1,1],[2,3],[3,5],[4,8],[6,4],[7,2]]
#
# x_values = data.map(&:first)
# x_range = (x_values.min)..(x_values.max)
#
# y_values = data.map(&:last)
# y_range = (y_values.min)..(y_values.max)

# @library_options = {
#   width: 600,
#   hAxis: {ticks: 10},
#   vAxis: {ticks: 10}
#
# }

  data_stat = Hash.new
  data_stat["A"]=0
  data_stat["B"]=0
  data_stat["C"]=0
  data_stat["D"]=0
  data_stat["E"]=0
  data_stat["F"]=0
  data =  Group.find(5).lessons.first.results.group(:mark).count
  data.each_pair {|key, value|

  if
    key.between?(90,100)
  data_stat["A"] += value
  end

  if
    key.between?(80,89)
  data_stat["B"] += value
  end

  if
    key.between?(75,80)
  data_stat["C"] += value
  end

  if
    key.between?(65,74)
  data_stat["D"] += value
  end

  if
    key.between?(59,65)
  data_stat["E"] += value
  end

  if
    key.between?(0,59)
  data_stat["F"] += value
  end
}
  @data_stat=data_stat
end
  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Lesson.new(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def attendance
    attendance = params[:attendance]
    attendance.each do |key, value|
      result = Result.find(key)
      result.attendance = value
      result.save
    end
    mark = params[:mark]
    mark.each do |key, value|
      result = Result.find(key)
      result.mark = value
      result.save
    end
      respond_to do |format|
        format.js
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:course_id, :typeL, :typeA, :date)
    end
end
