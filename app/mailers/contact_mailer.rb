# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  default from: 'no-reply@localhost'

  def contact_email(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(to: 'sakauchi.runteq@gmail.com', subject: 'お問い合わせ')
  end
end
