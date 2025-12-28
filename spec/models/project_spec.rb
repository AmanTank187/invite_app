require "rails_helper"

RSpec.describe Project, type: :model do
  describe "validations" do
    it "project is invalid without a name" do
      user = User.create(email: "test@example.com")
      project = Project.create(creator: user)
      expect(project).to be_invalid
    end

    it "project is invalid without a creator" do
      project = Project.create(name: "project 1")
      expect(project).to be_invalid
    end

    it "project is valid with creator and name" do
      user = User.create(email: "test@example.com")
      project = Project.create(name: "project 1", creator: user)
      expect(project).to be_valid
    end
  end
end
