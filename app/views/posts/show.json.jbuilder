json.extract! @post, :id, :title, :text

json.user do
  json.extract! @post.user, :id, :name, :email
end

json.comments @post.comments do |comment|
  json.extract! comment, :id, :description, :name
end
