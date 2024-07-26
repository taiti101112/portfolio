class PagesController < ApplicationController
  def privacy_policy
  end

  def terms_of_service
  end

  def contact
    if request.post?
      @name = params[:name]
      @message = params[:message]
      @contact_email = params[:email]

      ContactMailer.contact_email(@name, @contact_email, @message).deliver_now
      redirect_to contact_path, notice: "お問合せありがとうございました"
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
