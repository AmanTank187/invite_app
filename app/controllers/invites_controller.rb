class InvitesController < ApplicationController
  def create
    project_id = params["project_id"]
    invite = Invite.new(invite_params)
    invite.invited_by = current_user
    invite.project_id = project_id
    if invite.save
    render json: invite, status: :created
    else
    render json: { errors: invite.errors.full_messages },
           status: :unprocessable_entity
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:email, :role)
  end

  def current_user
    User.find_by(email: "admin+test@example.com")
  end
end
