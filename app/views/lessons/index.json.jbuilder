json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :course_id, :typeL, :typeA, :date
  json.url lesson_url(lesson, format: :json)
end
