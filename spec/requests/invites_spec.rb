require 'rails_helper'

RSpec.describe "Invites", type: :request do
  describe "POST /create" do
    it "returns http created" do
      admin = User.find_by(email: "admin+test@example.com")
      project = Project.create(name: "project 1")
      invitee = User.create(email: "invite+test@example.com")
      post project_invites_url(project), params: { invite: { email: "invite+test@example.com", role: "viewer" } }, as: :json

      expect(response).to have_http_status(:created)
      invite = Invite.last
      expect(invite.project_id).to eq(project.id)
      expect(invite.email).to eq(invitee.email)
      expect(invite.role).to eq("viewer")
      expect(invite.invited_by_id).to eq(admin.id)
    end

    it "returns 200 if invite has already been sent" do
      admin = User.find_by(email: "admin+test@example.com")
      project = Project.create(name: "project 1")
      invitee = User.create(email: "invite+test@example.com")
      Invite.create(project: project, invited_by: admin, role: "viewer", email: "invite+test@example.com")
      post project_invites_url(project), params: { invite: { email: "invite+test@example.com", role: "viewer" } }, as: :json

      expect(response).to have_http_status(:ok)
    end

    it "404 project not found" do
      post project_invites_url(99), params: { invite: { email: "invite+test@example.com", role: "viewer" } }, as: :json

      expect(response).to have_http_status(:not_found)
    end

    it "422 invalid role" do
      post project_invites_url(1), params: { invite: { email: "invite+test@example.com", role: "boss" } }, as: :json

      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe "PATCH /accept" do
    it "returns 404 in token is invalid" do
      patch accept_invite_url("token")
      expect(response).to have_http_status(:not_found)
    end

    it "returns 200 and membership if invite is already accepted" do
      admin = User.find_by(email: "admin+test@example.com")
      project = Project.create(name: "project 1")
      invitee = User.create(email: "invite+testmember@example.com")
      invite = Invite.create(project: project, invited_by: admin, role: "viewer", email: "invite+testmember@example.com", accepted_at: Time.now)
      ProjectMembership.create(project: project, user: invitee, role: "viewer")
      patch accept_invite_url(invite.token)
      debugger
      expect(response).to have_http_status(:ok)
    end
  end
end
