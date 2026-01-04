class InvitesController < ApplicationController
  before_action :set_project, only: [ :create ]
  def create
    invite = Invites::Create.call(
        project: @project,
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

  def set_project
    @project ||= Project.find(params[:project_id])
  end
end
