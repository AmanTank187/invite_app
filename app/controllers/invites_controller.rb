class InvitesController < ApplicationController
  before_action :set_project, only: [ :create ]
  before_action :validate_role!, only: [ :create ]
  def create
    invite = Invites::Create.call(
        project: @project,
        invited_by: current_user,
        invite_params: invite_params
    )
    if invite.persisted?
      status = invite.previous_changes.key?("id") ? :created : :ok
      render json: invite, status: status
    else
      render json: { errors: invite.errors.full_messages }, status: :unprocessable_entity
    end
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

  def validate_role!
    role = invite_params[:role]

    return if Invite.roles.key?(role)

    render json: {
      errors: "Role is not included in the list"
    }, status: :unprocessable_entity
  end
end
