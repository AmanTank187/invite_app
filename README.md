Mini-exercise: Project Invites + Membership Roles
Context

You’re working on a Rails app with:

User

Project

Membership (join table between users and projects)

You need to add an invite-by-email flow so existing project members can invite people to join a project with a role.

Requirements
<!-- 1) Data Model

Add an Invite model.

Invite fields

project_id (FK, required)

email (required)

role (required) — one of: viewer, editor, admin

token (required, unique, URL-safe)

invited_by_id (FK to users, required)

accepted_at (datetime, nullable)

timestamps

Rules

Email should be normalized (trim + downcase). Done

A project cannot have multiple pending invites for the same email. Done

“Pending” means accepted_at is NULL.

If the invited email already belongs to a user who is already a member of the project, inviting should not create a duplicate membership. Done

DB constraints (expected)

NOT NULL for required columns

Unique index for “one pending invite per project+email” Done

Unique index for token Done -->


2) Endpoint

Implement:

POST /projects/:id/invites

Request body

{ "email": "person@example.com", "role": "editor" }


Response

201 Created with invite JSON if created

200 OK with invite JSON if the same pending invite already exists (idempotent behavior)

422 Unprocessable Entity for invalid role/email

403 Forbidden if user lacks permission

404 Not Found if project doesn’t exist

Authorization rule
Only project members with role admin can invite.


3) Acceptance Flow

Implement:

POST /invites/:token/accept

Behavior

If token invalid: 404

If invite already accepted: 200 and return membership (idempotent)

Otherwise:

Mark invite accepted_at = Time.current

Create membership for the user on that project with the invite role

Do it in a transaction

Ensure you don’t create duplicate membership if one already exists


4) Email Delivery

When an invite is created, enqueue an email job:

InviteMailer.project_invite(invite_id).deliver_later

Must use after_commit (not after_save) to avoid sending emails for rolled-back records.



What to Implement (deliverables)

Migrations for invites (+ any improvements to memberships you think are needed)

Invite model (validations, enums, token generation, normalization)

Routes + controllers for both endpoints

Authorization (simple, doesn’t need Pundit, but can use it if you want)

A couple focused tests:

request spec for creating an invite (covers idempotency + auth)

model spec for uniqueness rule (pending invites)

request spec for accepting invite (creates membership, idempotent)


Edge Cases to Handle (explicitly)

email case differences (A@x.com vs a@x.com) shouldn’t create two pending invites

concurrent requests creating invites: avoid race condition duplicates (DB index must enforce)

accepting invite when user already has membership: do not duplicate membership

role must be from allowed set