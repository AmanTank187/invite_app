require "rails_helper"

RSpec.describe Membership, type: :model do
  describe "validations" do
    it "membership default role of viewer" do
      creator = User.create(email: "test@example.com")
      project = Project.create(name: "test project", creator: creator)
      invitee = User.create(email: "invite@example.com")

      membership = Membership.create(project: project, user: invitee)
      expect(membership.role).to eq("viewer")
    end
  end
end
