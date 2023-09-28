# db/seeds.rb

# Criando o usuário
user = User.create(
  email: "user@teste1.com",
  name: "isg teste",
  password: "ISG0923!!!"
)

# Verificando se o usuário foi criado com sucesso
if user.persisted?
  puts "Usuário criado com sucesso!"

  # Criando posts
  post_success = true
  5.times do
    post = Post.create(
      title: "Post",
      text: "#{FFaker::Lorem.word}",
      user_id: user.id
    )

    unless post.persisted?
      post_success = false
      puts "Falha ao criar post. Erros: #{post.errors.full_messages.join(', ')}"
    end
  end
  puts "Posts criados com sucesso!" if post_success

  # Criando comentários para os posts
  comment_success = true
  Post.all.each do |post|
    4.times do
      comment = Comment.create(
        name: FFaker::NameBR.name,
        description: "#{FFaker::Lorem.word}",
        post_id: post.id
      )

      unless comment.persisted?
        comment_success = false
        puts "Falha ao criar comentário. Erros: #{comment.errors.full_messages.join(', ')}"
      end
    end
  end
  puts "Comentários criados com sucesso!" if comment_success

else
  puts "Falha ao criar usuário. Erros: #{user.errors.full_messages.join(', ')}"
end
