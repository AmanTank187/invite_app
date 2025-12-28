require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "should have an email" do
      user = User.new()
      expect(user).to be_invalid
    end

    it "Cannot have two users with the same email" do
      User.create(email: "test@example.com")
      user = User.create(email: "Test@example.com")
      expect(user).to be_invalid
    end

    it "Email should be sanitised" do
      user = User.create(email: "Test@example.com   ")
      expect(user.email).to eq("test@example.com")
    end
  end
end
