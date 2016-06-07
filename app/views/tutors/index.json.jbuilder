json.array!(@tutors) do |tutor|
  json.extract! tutor, :id, :first_name, :second_name, :last_name
  json.url tutor_url(tutor, format: :json)
end
