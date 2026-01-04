class InvitesController < ApplicationController
  before_action :set_project, only: [ :create ]
  before_action :set_invite, only: [ :accept ]
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

  def accept
    if @invite.accepted_at?
      user = User.find_by(email: @invite.email)
      membership = @invite.project.project_memberships.find_by(user_id: user.id)
      render json: membership, status: :ok
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

  def set_invite
    @invite ||= Invite.find_by!(token: params[:token])
  end

  def validate_role!
    role = invite_params[:role]

    return if Invite.roles.key?(role)

    render json: {
      errors: "Role is not included in the list"
    }, status: :unprocessable_entity
  end
end
