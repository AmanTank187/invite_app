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
      invite.invited_by = @invited_by
      invite.project = @project
      invite.save!
      invite
    end
  end
end
