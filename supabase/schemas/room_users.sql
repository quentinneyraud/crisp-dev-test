create table room_users (
  id uuid primary key default gen_random_uuid(),
  room_id uuid not null references rooms(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  joined_at timestamp with time zone default now(),
  unique (room_id, user_id)
);

alter table room_users enable row level security;
