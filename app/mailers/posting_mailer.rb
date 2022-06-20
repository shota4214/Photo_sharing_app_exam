class PostingMailer < ApplicationMailer
  def posting_mail(picture, name, email)
    @picture = picture
    @user_name = name
    @user_email = email

    mail to: email, subject: "PicChum投稿確認メール"
  end
end
