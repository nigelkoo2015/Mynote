-- =====================================================================
-- Online Notepad — Supabase database schema
-- Run this entire file once inside Supabase → SQL Editor → New query.
--
-- If you already created the old tables, the two DROP lines below will
-- remove them first so this fresh schema can be created cleanly.
-- WARNING: dropping tables also deletes any rows currently in them.
-- =====================================================================

drop table if exists public.notes;
drop table if exists public.users;

-- 1) USERS table -------------------------------------------------------
create table public.users (
    id            uuid primary key default gen_random_uuid(),
    user_id       text unique not null,            -- login name chosen by the user
    security_key  text not null,                   -- stored as plain text
    full_name     text not null,
    country       text not null,
    email         text not null,
    approved      boolean not null default false,  -- admin flips this to true
    created_at    timestamptz not null default now()
);

-- 2) NOTES table -------------------------------------------------------
create table public.notes (
    id         uuid primary key default gen_random_uuid(),
    user_id    text not null references public.users(user_id) on delete cascade,
    title      text not null default 'Untitled',
    content    text not null default '',
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create index notes_user_id_idx on public.notes(user_id);

-- 3) Row Level Security -----------------------------------------------
alter table public.users disable row level security;
alter table public.notes disable row level security;
