class Group < ActiveRecord::Base
  has_and_belongs_to_many :courses
  has_many :students, dependent: :destroy
  has_many :lessons, dependent: :destroy


  def self.group_parse

    file = File.read("/home/fomy/rails/project/data/К04-361.json")

    data_hash = JSON.parse(file)

    data_hash['schedules'].each do |schedule|
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
