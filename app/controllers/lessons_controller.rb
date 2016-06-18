class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = Lesson.where(course_id: params["course"],group_id: params["group"])
    @students = Group.find(params["group"]).students
    @lesson_name = Course.find(params["course"])
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

def statistics_lesson
  data_stat_mark_lesson = Hash.new
   data_lesson=Group.find(params["group"]).lessons.find(params["id"]).results.group(:mark).count
    data_lesson.each_pair {|key, value|
      if !(key == nil)

      if
        key.between?(90,100)
      data_stat_mark_lesson["A"] += value
      end

      if
        key.between?(80,89)
      data_stat_mark_lesson["B"] += value
      end

      if
        key.between?(75,80)
      data_stat_mark_lesson["C"] += value
      end

      if
        key.between?(65,74)
    data_stat_mark_lesson["D"] += value
      end

      if
        key.between?(59,65)
      data_stat_mark_lesson["E"] += value
      end

      if
        key.between?(0,59)
      data_stat_mark_lesson["F"] += value
      end
    end
    }
    @data_stat_mark_lesson=data_stat_mark_lesson
end

def static


  data_stat_mark = Hash.new
  data_stat_mark["A"]=0
  data_stat_mark["B"]=0
  data_stat_mark["C"]=0
  data_stat_mark["D"]=0
  data_stat_mark["E"]=0
  data_stat_mark["F"]=0
  data_stat_attedance = Hash.new


  data =  Group.find(params["group"]).lessons.order(:date).each do |data_stat_on_lesson|

    d_a=data_stat_on_lesson.results.group(:attendance).count
    d_a.each_pair {|key, value|
      if key == true
        data_stat_attedance[data_stat_on_lesson.date.strftime('%d.%m')]=value
      end
            }
      @data_stat_attedance = data_stat_attedance


     @d_m=data_stat_on_lesson.results.group(:mark).count
     @d_m.each_pair {|key, value|
  if !(key == nil)

  if
    key.between?(90,100)
  data_stat_mark["A"] += value
  end

  if
    key.between?(80,89)
  data_stat_mark["B"] += value
  end

  if
    key.between?(75,80)
  data_stat_mark["C"] += value
  end

  if
    key.between?(65,74)
  data_stat_mark["D"] += value
  end

  if
    key.between?(59,65)
  data_stat_mark["E"] += value
  end

  if
    key.between?(0,59)
  data_stat_mark["F"] += value
  end
end
}
  end
  @data_stat_mark = data_stat_mark
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
