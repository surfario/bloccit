class FavoriteMailer < ActionMailer::Base
  default from: "ari.olmos@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    headers["Message-ID"] = "<comments/#{@comment.id}@surfario-bloccit.herokuapp.com>"
    headers["In-Reply-To"] = "<post/#{@post.id}@surfario-bloccit.herokuapp.com>"
    headers["References"] = "<post/#{@post.id}@surfario-bloccit.herokuapp.com>"

    mail(to: user.email, subject: "New comment on #{post.title}")
  end  
end
