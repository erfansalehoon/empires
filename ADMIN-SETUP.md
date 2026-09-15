# Empires — Admin & Required Membership Setup

## Roles
- `SUPER_ADMIN`: technical/system owner. Bootstrap with `SUPER_ADMIN_TELEGRAM_ID`.
- `UN_ADMIN`: in-game United Nations administrator. In the fully upgraded backend this role should be stored in PostgreSQL and managed from the admin panel.

## Required Channels / Groups
The production design is:
1. Add the bot to every required channel/group.
2. Give the bot the permissions needed to call Telegram `getChatMember`.
3. Store required chat IDs and active/required status in PostgreSQL.
4. On Mini App login, the server checks every active required chat before allowing the player into the game.

Example configuration values (do not expose bot tokens):
- `REQUIRED_CHANNELS=@EmpiresOfficial`
- `REQUIRED_GROUPS=@EmpiresCommunity`

The current package includes the configuration placeholders and deployment structure, but the full database-backed UN Admin and required-membership management panel still requires the corresponding backend/UI implementation before it can be called production-complete.
