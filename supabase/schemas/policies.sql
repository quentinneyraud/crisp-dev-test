-- Messages

create policy "read messages"
on message for select
using (
  exists (
    select 1
    from room_users
    where room_users.room_id = message.room_id
    and room_users.user_id = (select auth.uid())
  )
);

create policy "send message"
on message for insert
with check (
  (select auth.uid()) = created_by
  and exists (
    select 1
    from room_users
    where room_users.room_id = message.room_id
    and room_users.user_id = (select auth.uid())
  )
);

-- Rooms users

create policy "select room users"
on room_users for select
using (
  is_user_in_room(room_id)
);

create policy "join room"
on room_users for insert
with check ((select auth.uid()) = user_id);

-- Rooms

create policy "select rooms"
on room for select
using (
  true
);

create policy "create room"
on room for insert
with check ((select auth.uid()) = created_by);


-- Profile

create policy "read profile"
on profile for select
using (
  share_room_with(id)
);

create policy "insert profile"
on profile
for insert
with check (
  id = auth.uid()
);
