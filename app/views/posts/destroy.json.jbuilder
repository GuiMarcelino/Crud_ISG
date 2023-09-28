json.post do
  json.message "Post deleted successfully"
  json.id @post.id
end
