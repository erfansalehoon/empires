create table if not exists users(id bigserial primary key,telegram_id text unique not null,first_name text not null,last_name text,username text,is_vip boolean not null default false,is_banned boolean not null default false,is_admin boolean not null default false,created_at timestamptz not null default now());
create table if not exists sessions(token text primary key,user_id bigint not null references users(id) on delete cascade,expires_at timestamptz not null);
create table if not exists worlds(id bigserial primary key,name text not null,code text unique not null,status text not null default 'RECRUITING',season_number int not null default 1,season_length_days int not null default 30,current_game_day int not null default 0,starts_at timestamptz,ends_at timestamptz,created_at timestamptz not null default now());
create table if not exists countries(id bigserial primary key,world_id bigint not null references worlds(id) on delete cascade,code text not null,name text not null,flag_emoji text not null default '🏳️',is_vip_only boolean not null default false,status text not null default 'FREE',owner_user_id bigint references users(id) on delete set null,treasury numeric(18,2) not null default 10000,population bigint not null default 100000,satisfaction numeric(5,2) not null default 70,electricity_capacity numeric(18,2) not null default 100,electricity_produced numeric(18,2) not null default 100,electricity_consumed numeric(18,2) not null default 50,infrastructure_level int not null default 1,army_power numeric(18,2) not null default 100,government_type text not null default 'REPUBLIC',tax_rate numeric(5,4) not null default .15,formed_at timestamptz,created_at timestamptz not null default now(),unique(world_id,code));
create unique index if not exists uq_country_owner on countries(world_id,owner_user_id) where owner_user_id is not null;
create table if not exists ledger_transactions(id bigserial primary key,world_id bigint not null references worlds(id),country_id bigint not null references countries(id),amount numeric(18,2) not null,type text not null,source text,destination text,game_day int not null,reference text unique,created_at timestamptz not null default now());
create table if not exists world_ticks(id bigserial primary key,world_id bigint not null references worlds(id) on delete cascade,game_day int not null,status text not null default 'RUNNING',started_at timestamptz not null default now(),completed_at timestamptz,unique(world_id,game_day));
create table if not exists audit_logs(id bigserial primary key,actor_user_id bigint references users(id),action text not null,target_type text,target_id text,payload_json jsonb,created_at timestamptz not null default now());


-- Empires v2: administration and required Telegram membership
CREATE TABLE IF NOT EXISTS user_roles (
  user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role TEXT NOT NULL CHECK (role IN ('PLAYER','UN_ADMIN','SUPER_ADMIN')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (user_id, role)
);

CREATE TABLE IF NOT EXISTS required_chats (
  id BIGSERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  chat_id TEXT NOT NULL UNIQUE,
  username TEXT,
  chat_type TEXT NOT NULL CHECK (chat_type IN ('CHANNEL','GROUP','SUPERGROUP')),
  is_required BOOLEAN NOT NULL DEFAULT TRUE,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS admin_audit_logs (
  id BIGSERIAL PRIMARY KEY,
  actor_user_id BIGINT REFERENCES users(id) ON DELETE SET NULL,
  action TEXT NOT NULL,
  target_type TEXT,
  target_id TEXT,
  metadata JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_required_chats_active
  ON required_chats (is_active, is_required);
