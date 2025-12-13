create table messages (
  id uuid primary key default gen_random_uuid(),
  room_id uuid not null references rooms(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  content text not null,
  created_at timestamp with time zone default now()
);

create index messages_room_id_created_at_idx
  on messages (room_id, created_at desc);

alter table messages enable row level security;
