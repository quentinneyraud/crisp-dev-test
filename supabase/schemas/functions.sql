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
