  desc "Parse data from JSON"
  task :parse do



def parse
  file = File.read("/home/fomy/rails/project/data/К04-361.json")

  data_hash = JSON.parse(file)

  data_hash['schedules'].each do |schedule|
    schedule['tutors'].each do |tutorJSON|
      tutor = Tutor.new
      tutor.name = tutorJSON['last_name'] + " " + tutorJSON['first_name'] + " " + tutorJSON['second_name']
      if (Tutor.find_by name: tutor.name)==nil
        tutor.save
      end


    end
    schedule['courses'].each do |courseJSON|
      course = Course.new
      course.name = courseJSON['course']['name']
      if (Course.find_by name: course.name)==nil
        course.save
      end

    schedule['courses'].each do |groupJSON|
        group = Group.new
        group.name = groupJSON['group']['name']
        if (Group.find_by name: group.name)==nil
          group.save
        end

        end
      end
    end
  end
end
