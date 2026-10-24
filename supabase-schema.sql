-- Baobab Suite RH : espace central privé, une ligne par utilisateur authentifié.
-- Exécuter dans Supabase > SQL Editor, après création du projet.
create table if not exists public.baobab_workspace (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{"agents":[],"conges":[],"courriers":[],"documents":[],"contacts":[],"actes":[],"archivesActes":[],"cfg":{"svc":"","av":2,"droit":30}}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.baobab_workspace enable row level security;
revoke all on table public.baobab_workspace from anon;
revoke all on table public.baobab_workspace from authenticated;
grant select, insert, update on table public.baobab_workspace to authenticated;
drop policy if exists "workspace_select_own" on public.baobab_workspace;
drop policy if exists "workspace_insert_own" on public.baobab_workspace;
drop policy if exists "workspace_update_own" on public.baobab_workspace;
create policy "workspace_select_own" on public.baobab_workspace for select to authenticated using (auth.uid() = user_id);
create policy "workspace_insert_own" on public.baobab_workspace for insert to authenticated with check (auth.uid() = user_id);
create policy "workspace_update_own" on public.baobab_workspace for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
