# frozen_string_literal: true

class PagesController < ApplicationController
  # プライバシーポリシー
  def privacy_policy; end

  # 利用規約
  def terms_of_service; end

  # お問い合わせ機能
  def contact
    if request.post?
      @name = params[:name]
      @message = params[:message]
      @contact_email = params[:email]
      # 指定されたメールアドレスにメールを送信
      ContactMailer.contact_email(@name, @contact_email, @message).deliver_now
      redirect_to contact_path, notice: 'お問合せありがとうございました'
    else
      @name = ''
      @message = ''
      @contact_email = ''
    end
  end

  private

  def contact_params
    params.permit(:name, :email, :message)
  end
end
