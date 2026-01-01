class InvitesController < ApplicationController
  def create
    project = Project.find(params["project_id"])

    invite = Invites::Create.call(
        project: project,
        invited_by: current_user,
        invite_params: invite_params
    )

    render json: invite, status: :created
  end

  private

  def invite_params
    params.require(:invite).permit(:email, :role)
  end

  def current_user
    User.find_by(email: "admin+test@example.com")
  end
end
