json.array! @comments do |comment|
  json.extract! comment, :id, :description, :name

  json.post do
    json.extract! comment.post, :id, :title, :text

    json.user do
      json.extract! comment.post.user, :id, :name, :email
    end
  end
end
