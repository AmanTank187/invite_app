require "rails_helper"

RSpec.describe ProjectMembership, type: :model do
  describe "validations" do
    it "membership default role of viewer" do
      creator = User.create(email: "test@example.com")
      project = Project.create(name: "test project", creator: creator)
      invitee = User.create(email: "invite@example.com")

      membership = ProjectMembership.create(project: project, user: invitee)
      expect(membership.role).to eq("viewer")
    end

    it "cannot have duplicate membership for the same project" do
      creator = User.create(email: "test@example.com")
      project = Project.create(name: "test project", creator: creator)
      invitee = User.create(email: "invite@example.com")

      ProjectMembership.create(project: project, user: invitee)
      duplicate_membership = ProjectMembership.new(project: project, user: invitee)
      expect(duplicate_membership).to be_invalid
    end
  end
end
