require "rails_helper"

RSpec.describe Project, type: :model do
  describe "validations" do
    it "project is valid with creator and name" do
      user = User.create(email: "test@example.com")
      project = Project.create(name: "project 1")
      expect(project).to be_valid
    end
  end
end
