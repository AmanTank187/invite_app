require "rails_helper"

RSpec.describe Invites::Create, type: :service do
  describe ".call" do
    it "it creates an invite" do
      admin = User.find_by(email: "admin+test@example.com")
      invitee = User.create(email: "invite1+test@example.com")
      project = Project.create(name: "project 2")

      Invites::Create.call(
        project: project,
        invited_by: admin,
        invite_params: { email: "invite1+test@example.com", role: "viewer" }
      )

      invite = Invite.last
      expect(invite.project_id).to eq(project.id)
      expect(invite.email).to eq(invitee.email)
      expect(invite.role).to eq("viewer")
      expect(invite.invited_by_id).to eq(admin.id)
    end
  end
end
