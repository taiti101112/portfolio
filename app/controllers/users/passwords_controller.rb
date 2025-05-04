# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController
    # GET /resource/password/new
    # def new
    #   super
    # end

    def create
      self.resource = resource_class.send_reset_password_instructions(resource_params)

      if successfully_sent?(resource)
        flash[:notice] = 'パスワードリセットの手順を記載したメールを送信しました。'
        redirect_to new_session_path(resource_name)
      else
        flash[:alert] = 'メールアドレスが登録されていません。'
        redirect_to new_password_path(resource_name)
      end
    end

    # GET /resource/password/edit?reset_password_token=abcdef
    # def edit
    #   super
    # end

    # PUT /resource/password
    # def update
    #   super
    # end

    # protected

    # def after_resetting_password_path_for(resource)
    #   super(resource)
    # end

    # The path used after sending reset password instructions
    # def after_sending_reset_password_instructions_path_for(resource_name)
    #   super(resource_name)
    # end
  end
end
