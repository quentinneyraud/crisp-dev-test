-- Messages

create policy "read messages"
on messages for select
using (
  exists (
    select 1
    from room_users
    where room_users.room_id = messages.room_id
    and room_users.user_id = auth.uid()
  )
);

create policy "send message"
on messages for insert
with check (
  auth.uid() = user_id
  and exists (
    select 1
    from room_users
    where room_users.room_id = messages.room_id
    and room_users.user_id = auth.uid()
  )
);

-- Rooms users

create policy "select room users"
on room_users for select
using (
  user_id = auth.uid()
);

create policy "join room"
on room_users for insert
with check (auth.uid() = user_id);

-- Rooms

create policy "select rooms"
on rooms for select
using (
  exists (
    select 1
    from room_users
    where room_users.room_id = rooms.id
    and room_users.user_id = auth.uid()
  )
);

create policy "create room"
on rooms for insert
with check (auth.uid() = created_by);
