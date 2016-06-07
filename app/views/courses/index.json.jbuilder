json.array!(@courses) do |course|
  json.extract! course, :id, :name, :tutor_id, :group_id, :started_date, :finished_date, :started_time, :finished_time, :period, :wday, :room_name
  json.url course_url(course, format: :json)
end
