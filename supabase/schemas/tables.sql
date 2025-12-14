-- Room

create table room (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  created_by uuid not null references auth.users(id) default auth.uid(),
  created_at timestamp with time zone default now()
);

alter table room enable row level security;

-- Message

create table message (
  id uuid primary key default gen_random_uuid(),
  room_id uuid not null references room(id) on delete cascade,
  created_by uuid not null references auth.users(id) on delete cascade default auth.uid(),
  content text not null,
  created_at timestamp with time zone default now()
);

alter table message enable row level security;


-- Room users

create table room_users (
  id uuid primary key default gen_random_uuid(),
  room_id uuid not null references room(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade default auth.uid(),
  joined_at timestamp with time zone default now(),
  unique (room_id, user_id)
);

alter table room_users enable row level security;
