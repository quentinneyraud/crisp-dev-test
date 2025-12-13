create table rooms (
  id uuid primary key default gen_random_uuid(),
  name text not null unique,
  created_by uuid not null references auth.users(id),
  created_at timestamp with time zone default now()
);

alter table rooms enable row level security;
