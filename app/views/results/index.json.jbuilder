json.array!(@results) do |result|
  json.extract! result, :id, :attendance, :mark, :student_id, :lesson_id
  json.url result_url(result, format: :json)
end
