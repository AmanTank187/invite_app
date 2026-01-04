module Invites
  class Create
    def self.call(project:, invited_by:, invite_params:)
      new(project, invited_by, invite_params).call
    end

    def initialize(project, invited_by, invite_params)
      @project = project
      @invited_by = invited_by
      @invite_params = invite_params
    end

    def call
      invite = Invite.new(@invite_params)
      invite = Invite.find_or_initialize_by(
        project: @project,
        email: @invite_params[:email]
      )
      invite.invited_by = @invited_by
      invite.assign_attributes(@invite_params)
      invite.save if invite.new_record?
      invite
    end
  end
end
