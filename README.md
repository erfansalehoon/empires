# Empires



## Empires v2 — Admin & Required Membership

This update adds PostgreSQL tables and API endpoints for `UN_ADMIN`, required Telegram chats, audit logs, and a membership status check. `SUPER_ADMIN_TELEGRAM_ID` remains the bootstrap owner. The bot must be able to call Telegram `getChatMember` for required chats. Do not expose `DATABASE_URL` or `TELEGRAM_BOT_TOKEN` as `NEXT_PUBLIC_*` variables.
