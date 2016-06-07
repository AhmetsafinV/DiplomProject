class Student < ActiveRecord::Base
  belongs_to :group
  has_many :results, dependent: :destroy


  def self.student_add

    group_id=Group.find_by(name:"К08-362").id


    f = File.open("/home/fomy/rails/project/data/K08-362_stud", "r")
    f.each_line do |line|
      fullname = line.split(" ")
      student = Student.new
      student.last_name = fullname[0]
      student.first_name = fullname[1]
      student.second_name = fullname[2]
      student.group_id = group_id
      student.save
    end
    f.close

  end
end
