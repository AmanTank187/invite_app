require "rails_helper"

RSpec.describe Invite, type: :model do
  describe "validations" do
    it "Email should be sanitised" do
      user = User.create(email: "creator@example.com")
      project = Project.create(name: "project 1")
      invite = Invite.create(project: project, email: "Test@example.com   ", role: "viewer", invited_by: user)
      expect(invite.email).to eq("test@example.com")
    end
  end
end
