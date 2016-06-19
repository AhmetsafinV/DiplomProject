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
    one_lesson_stat
    student_stat
    tutor_stat
    group_stat_mark
    lesson_stat_wday
    stat_att
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

  def lesson_stat_wday
    lesson_stat_wday=Hash.new

    data3  = Course.where(wday: 3).each do |c|
      d_c = c.lessons.each do |l|
        d_a = l.results.group(:attendance).count
          d_a.each_pair{|key,value|
          if key == true
            lesson_stat_wday["Среда"]=value
          end
                }
      end
    end

    data4  = Course.where(wday: 4).each do |c|
      d_c = c.lessons.each do |l|
        d_a = l.results.group(:attendance).count
          d_a.each_pair{|key,value|
          if key == true
            lesson_stat_wday["Понедельник"]=value
          end
                }
      end
    end
      @lesson_stat_wday = lesson_stat_wday
  end

  def group_stat_mark
    group_stat_mark = Hash.new
    group_stat_mark["A"]=0
    group_stat_mark["B"]=0
    group_stat_mark["C"]=0
    group_stat_mark["D"]=0
    group_stat_mark["E"]=0
    group_stat_mark["F"]=0
    data = Group.find(5).students.each do |s|
      d=s.results.group(:mark).count
      d.each_pair{|key, value|
        case key
        when 1..59
          group_stat_mark["F"]+=value
        when 60..64
          group_stat_mark["E"]+=value
        when 65..74
          group_stat_mark["D"]=+value
        when 75..84
          group_stat_mark["C"]=+value
        when 85..89
          group_stat_mark["B"]+=value
        when 90..100
          group_stat_mark["A"]+=value
        end
      }
    end
  @group_stat_mark_mark = group_stat_mark
  end
def tutor_stat
  tutor_stat = Hash.new
  tutor_stat["A"]=0
  tutor_stat["B"]=0
  tutor_stat["C"]=0
  tutor_stat["D"]=0
  tutor_stat["E"]=0
  tutor_stat["F"]=0

  data =  Tutor.find(44).courses.each do |c|
    d = c.lessons.each do |data_stat_on_tutor|
    d_t=data_stat_on_tutor.results.group(:mark).count
    d_t.each_pair {|key, value|
      case key
      when 1..59
        tutor_stat["F"]+=value
      when 60..64
        tutor_stat["E"]+=value
      when 65..74
        tutor_stat["D"]=+value
      when 75..84
        tutor_stat["C"]=+value
      when 85..89
        tutor_stat["B"]+=value
      when 90..100
        tutor_stat["A"]+=value
      end
        }

    end
  end
    @tutor_stat_mark = tutor_stat
end
def student_stat
  student_stat = Hash.new
  student_stat["A"]=0
  student_stat["B"]=0
  student_stat["C"]=0
  student_stat["D"]=0
  student_stat["E"]=0
  student_stat["F"]=0
  data = Student.first.results.group(:mark).count
  data.each_pair { |key,value|
    case key
    when 1..59
      student_stat["F"]+=value
    when 60..64
      student_stat["E"]+=value
    when 65..74
      student_stat["D"]=+value
    when 75..84
      student_stat["C"]=+value
    when 85..89
      student_stat["B"]+=value
    when 90..100
      student_stat["A"]+=value
    end
    }
@student_stat=student_stat

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

def one_lesson_stat
  one_lesson_stat = Hash.new
  one_lesson_stat["A"]=0
  one_lesson_stat["B"]=0
  one_lesson_stat["C"]=0
  one_lesson_stat["D"]=0
  one_lesson_stat["E"]=0
  one_lesson_stat["F"]=0
  data = Group.find(5).lessons.find(60).results.group(:mark).count
  data.each_pair { |key,value|
    case key
    when 1..59
      one_lesson_stat["F"]+=value
    when 60..64
      one_lesson_stat["E"]+=value
    when 65..74
      one_lesson_stat["D"]=+value
    when 75..84
      one_lesson_stat["C"]=+value
    when 85..89
      one_lesson_stat["B"]+=value
    when 90..100
      one_lesson_stat["A"]+=value
    end
    }
@one_lesson_stat=one_lesson_stat


end

def stat_att
  data_stat_attedance = Hash.new
  data2 = Course.find(194).lessons.each do |l|

    d_a=l.results.group(:attendance).count
    d_a.each_pair {|key, value|
if key == true
        data_stat_attedance[l.date.strftime('%d.%m')]=value
      end
            }
      @data_stat_attedance = data_stat_attedance
    end

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
