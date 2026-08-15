-- Run in Supabase SQL Editor. Do not put the admin access code in the client app.
create extension if not exists pgcrypto;
create table if not exists profile (id uuid primary key default gen_random_uuid(), name text, role text, headline text, email text, location text, photo_url text, about text, status text default 'published', display_order int default 0, created_at timestamptz default now(), updated_at timestamptz default now());
create table if not exists organizations (id uuid primary key default gen_random_uuid(), name text not null, logo_url text, status text default 'published', display_order int default 0, created_at timestamptz default now(), updated_at timestamptz default now());
create table if not exists skills (id uuid primary key default gen_random_uuid(), name text not null, level text, icon_url text, status text default 'published', display_order int default 0, created_at timestamptz default now(), updated_at timestamptz default now());
create table if not exists projects (id uuid primary key default gen_random_uuid(), title text not null, description text, category text, stack text[] default '{}', cover_url text, problem text, insights text, status text default 'published', display_order int default 0, created_at timestamptz default now(), updated_at timestamptz default now());
create table if not exists certificates (id uuid primary key default gen_random_uuid(), title text not null, organization text, issue_date text, credential_id text, file_url text, status text default 'published', display_order int default 0, created_at timestamptz default now(), updated_at timestamptz default now());
create table if not exists offer_letters (id uuid primary key default gen_random_uuid(), company text not null, position text, type text, duration text, mode text, image_url text, file_url text, status text default 'published', display_order int default 0, created_at timestamptz default now(), updated_at timestamptz default now());
create table if not exists achievements (id uuid primary key default gen_random_uuid(), title text not null, organization text, description text, date text, image_url text, status text default 'published', display_order int default 0, created_at timestamptz default now(), updated_at timestamptz default now());
create table if not exists contact_messages (id uuid primary key default gen_random_uuid(), name text, email text, subject text, message text, created_at timestamptz default now());
alter table profile enable row level security; alter table organizations enable row level security; alter table skills enable row level security; alter table projects enable row level security; alter table certificates enable row level security; alter table offer_letters enable row level security; alter table achievements enable row level security;
create policy "public reads published organizations" on organizations for select using (status='published');
create policy "public reads published skills" on skills for select using (status='published');
create policy "public reads published projects" on projects for select using (status='published');
create policy "public reads published certificates" on certificates for select using (status='published');
create policy "public reads published offers" on offer_letters for select using (status='published');
create policy "public reads published profile" on profile for select using (status='published');
create policy "public reads published achievements" on achievements for select using (status='published');
-- Add authenticated-admin write policies only after configuring Supabase Auth and an is_admin() JWT claim.
-- Security note: validate access-code attempts in a server-side Edge Function; do not expose it in SQL migrations or browser code.
