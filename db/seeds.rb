# db/seeds.rb

# Criando o usuário
user = User.create(
  email: "user@teste1.com",
  name: "isg teste",
  password: "ISG0923!!!"
)

# Verificando se o usuário foi criado com sucesso
if user.persisted?
  # Criando posts
  5.times do |post_index|
    post = Post.create(
      title: "Post #{post_index + 1}",
      text: "#{FFaker::Lorem.word} #{post_index + 1}",
      user_id: user.id
    )

    # Verificando se o post foi criado com sucesso
    if post.persisted?
      # Criando comentários para o post
      4.times do |comment_index|
        Comment.create(
          description: "#{FFaker::Lorem.word} #{comment_index + 1} for post #{post_index + 1}",
          post_id: post.id
        )
      end
    else
      puts "Falha ao criar post #{post_index + 1}. Erros: #{post.errors.full_messages.join(', ')}"
    end
  end
else
  puts "Falha ao criar usuário. Erros: #{user.errors.full_messages.join(', ')}"
end
