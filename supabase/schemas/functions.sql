create function auto_join_room_after_creation()
returns trigger
language plpgsql
as $$
begin
  insert into public.room_users(room_id)
  values (new.id);
  return new;
end;
$$;

create or replace function is_user_in_room(p_room_id uuid)
returns boolean
language sql
security definer
set search_path = public
as $$
  select exists (
    select 1
    from room_users
    where room_id = p_room_id
    and user_id = auth.uid()
  );
$$;

create or replace function handle_new_user()
returns trigger
language plpgsql
security definer set search_path = ''
as $$
begin
  insert into public.profile (id, email)
  values (new.id, new.email);
  return new;
end;
$$;

create or replace function share_room_with(p_user_id uuid)
returns boolean
language sql
security definer
set search_path = public
as $$
  select exists (
    select 1
    from room_users ru1
    join room_users ru2 on ru1.room_id = ru2.room_id
    where ru1.user_id = auth.uid()
    and ru2.user_id = p_user_id
  );
$$;
