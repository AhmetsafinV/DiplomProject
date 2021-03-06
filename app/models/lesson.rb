class Lesson < ActiveRecord::Base
  has_many :results, dependent: :destroy
  belongs_to :course
  belongs_to :group

def self.add_lessons(course, group)

  course = Course.find(course)
  group = Group.find(group)

  epoch = Date.new(1970,1,1)
  lesson = Lesson.new
  typeL = course.human_htype
  course_id = course.id
  date = (course.started_date - epoch).to_i
  finished_date = (course.finished_date - epoch).to_i
  wday = course.wday
  if course.period == 0
      period = 7
  elsif course.period == 1
    period = 14
    date+=7
  else
    period = 14
  end


  while date <= finished_date
    lesson_date = Date.new(1970,1,1)
    lesson_date+=date+wday
    lesson=Lesson.where(:typeL => typeL, :course_id => course_id, :date => lesson_date, :group_id => group.id).first_or_create

      group.students.each do |student|
        result=Result.where(:student_id => student.id, :lesson_id => lesson.id).first_or_create
      end
    date+=period
  end


  lesson = Lesson.new
  lesson_date = ((course.started_date - epoch).to_i + (course.finished_date - epoch).to_i )/2
  date = Date.new(1970,1,1)
  date+=lesson_date
  lesson=Lesson.where(:typeL => typeL, :course_id => course_id, :typeA => "Полусеместровый контроль", :group_id => group.id, :date =>date).first_or_create
    group.students.each do |student|
      result=Result.where(:student_id => student.id, :lesson_id => lesson.id).first_or_create
    end
    lesson = Lesson.new
    lesson_date = Date.new(1970,1,1)
    lesson=Lesson.where(:typeL => typeL, :course_id => course_id, :typeA => "Семестровый контроль", :group_id => group.id, :date => course.finished_date).first_or_create

      group.students.each do |student|
        result=Result.where(:student_id => student.id, :lesson_id => lesson.id).first_or_create
      end



end

end
