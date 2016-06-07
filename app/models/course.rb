class Course < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_and_belongs_to_many :tutors
  has_and_belongs_to_many :groups

  def self.courses_parse

      file = File.read("/home/fomy/rails/project/data/К08-362.json")

      data_hash = JSON.parse(file)

      data_hash['schedules'].each do |schedule|
        course = Course.new
        course.started_date = schedule['started_date']
        course.finished_date = schedule['finished_date']
        course.started_time = schedule['started_time'].to_i
        course.finished_time = schedule['finished_time'].to_i
        course.period = schedule['period']
        course.wday = schedule['wday']
        course.room_name = schedule['room']['name']

        schedule['courses'].each do |courseJSON|
          course.name = courseJSON['course']['name']
          course.human_htype = courseJSON['human_htype']
            end

        if !(Course.exists?(:name => course.name, :started_date => course.started_date, :finished_date => course.finished_date, :finished_time => course.finished_time, :started_time => course.started_time, :wday=>course.wday, :room_name => course.room_name ))
              course.save
        end
          course = Course.where(:name => course.name, :started_date => course.started_date, :finished_date => course.finished_date, :finished_time => course.finished_time, :started_time => course.started_time, :wday=>course.wday, :room_name => course.room_name)
          schedule['tutors'].each do |tutorJSON|
            last_name = tutorJSON['last_name']
            first_name = tutorJSON['first_name']
            second_name = tutorJSON['second_name']
            tutor=Tutor.where(:last_name => last_name, :first_name => first_name, :second_name => second_name).first_or_create


            tutor.courses << course


            schedule['courses'].each do |groupJSON|
                group = Group.new
                group.name = groupJSON['group']['name']
                group=Group.where(:name => group.name).first_or_create


              group.courses << course


          end
      end
    end
  end
end
