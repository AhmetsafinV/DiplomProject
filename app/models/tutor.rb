class Tutor < ActiveRecord::Base
  has_and_belongs_to_many :courses

def self.tutor_parse
  file = File.read("/home/fomy/rails/project/data/К04-361.json")

  data_hash = JSON.parse(file)

  data_hash['schedules'].each do |schedule|
    schedule['tutors'].each do |tutorJSON|
      tutor = Tutor.new
      tutor.last_name = tutorJSON['last_name']
      tutor.first_name = tutorJSON['first_name']
      tutor.second_name = tutorJSON['second_name']
        if !(Tutor.exists?(:last_name => tutor.last_name, :first_name => tutor.first_name, :second_name => tutor.second_name))
          tutor.save
        end
      end
    end
  end
end
