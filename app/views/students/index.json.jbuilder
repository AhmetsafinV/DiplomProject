json.array!(@students) do |student|
  json.extract! student, :id, :first_name, :second_name, :last_name, :group_id
  json.url student_url(student, format: :json)
end
