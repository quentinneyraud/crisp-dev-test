
  create table "public"."messages" (
    "id" uuid not null default gen_random_uuid(),
    "room_id" uuid not null,
    "user_id" uuid not null,
    "content" text not null,
    "created_at" timestamp with time zone default now()
      );


alter table "public"."messages" enable row level security;


  create table "public"."room_users" (
    "id" uuid not null default gen_random_uuid(),
    "room_id" uuid not null,
    "user_id" uuid not null,
    "joined_at" timestamp with time zone default now()
      );


alter table "public"."room_users" enable row level security;


  create table "public"."rooms" (
    "id" uuid not null default gen_random_uuid(),
    "name" text not null,
    "created_by" uuid not null,
    "created_at" timestamp with time zone default now()
      );


alter table "public"."rooms" enable row level security;

CREATE UNIQUE INDEX messages_pkey ON public.messages USING btree (id);

CREATE INDEX messages_room_id_created_at_idx ON public.messages USING btree (room_id, created_at DESC);

CREATE UNIQUE INDEX room_users_pkey ON public.room_users USING btree (id);

CREATE UNIQUE INDEX room_users_room_id_user_id_key ON public.room_users USING btree (room_id, user_id);

CREATE UNIQUE INDEX rooms_name_key ON public.rooms USING btree (name);

CREATE UNIQUE INDEX rooms_pkey ON public.rooms USING btree (id);

alter table "public"."messages" add constraint "messages_pkey" PRIMARY KEY using index "messages_pkey";

alter table "public"."room_users" add constraint "room_users_pkey" PRIMARY KEY using index "room_users_pkey";

alter table "public"."rooms" add constraint "rooms_pkey" PRIMARY KEY using index "rooms_pkey";

alter table "public"."messages" add constraint "messages_room_id_fkey" FOREIGN KEY (room_id) REFERENCES public.rooms(id) ON DELETE CASCADE not valid;

alter table "public"."messages" validate constraint "messages_room_id_fkey";

alter table "public"."messages" add constraint "messages_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."messages" validate constraint "messages_user_id_fkey";

alter table "public"."room_users" add constraint "room_users_room_id_fkey" FOREIGN KEY (room_id) REFERENCES public.rooms(id) ON DELETE CASCADE not valid;

alter table "public"."room_users" validate constraint "room_users_room_id_fkey";

alter table "public"."room_users" add constraint "room_users_room_id_user_id_key" UNIQUE using index "room_users_room_id_user_id_key";

alter table "public"."room_users" add constraint "room_users_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."room_users" validate constraint "room_users_user_id_fkey";

alter table "public"."rooms" add constraint "rooms_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."rooms" validate constraint "rooms_created_by_fkey";

alter table "public"."rooms" add constraint "rooms_name_key" UNIQUE using index "rooms_name_key";

grant delete on table "public"."messages" to "anon";

grant insert on table "public"."messages" to "anon";

grant references on table "public"."messages" to "anon";

grant select on table "public"."messages" to "anon";

grant trigger on table "public"."messages" to "anon";

grant truncate on table "public"."messages" to "anon";

grant update on table "public"."messages" to "anon";

grant delete on table "public"."messages" to "authenticated";

grant insert on table "public"."messages" to "authenticated";

grant references on table "public"."messages" to "authenticated";

grant select on table "public"."messages" to "authenticated";

grant trigger on table "public"."messages" to "authenticated";

grant truncate on table "public"."messages" to "authenticated";

grant update on table "public"."messages" to "authenticated";

grant delete on table "public"."messages" to "service_role";

grant insert on table "public"."messages" to "service_role";

grant references on table "public"."messages" to "service_role";

grant select on table "public"."messages" to "service_role";

grant trigger on table "public"."messages" to "service_role";

grant truncate on table "public"."messages" to "service_role";

grant update on table "public"."messages" to "service_role";

grant delete on table "public"."room_users" to "anon";

grant insert on table "public"."room_users" to "anon";

grant references on table "public"."room_users" to "anon";

grant select on table "public"."room_users" to "anon";

grant trigger on table "public"."room_users" to "anon";

grant truncate on table "public"."room_users" to "anon";

grant update on table "public"."room_users" to "anon";

grant delete on table "public"."room_users" to "authenticated";

grant insert on table "public"."room_users" to "authenticated";

grant references on table "public"."room_users" to "authenticated";

grant select on table "public"."room_users" to "authenticated";

grant trigger on table "public"."room_users" to "authenticated";

grant truncate on table "public"."room_users" to "authenticated";

grant update on table "public"."room_users" to "authenticated";

grant delete on table "public"."room_users" to "service_role";

grant insert on table "public"."room_users" to "service_role";

grant references on table "public"."room_users" to "service_role";

grant select on table "public"."room_users" to "service_role";

grant trigger on table "public"."room_users" to "service_role";

grant truncate on table "public"."room_users" to "service_role";

grant update on table "public"."room_users" to "service_role";

grant delete on table "public"."rooms" to "anon";

grant insert on table "public"."rooms" to "anon";

grant references on table "public"."rooms" to "anon";

grant select on table "public"."rooms" to "anon";

grant trigger on table "public"."rooms" to "anon";

grant truncate on table "public"."rooms" to "anon";

grant update on table "public"."rooms" to "anon";

grant delete on table "public"."rooms" to "authenticated";

grant insert on table "public"."rooms" to "authenticated";

grant references on table "public"."rooms" to "authenticated";

grant select on table "public"."rooms" to "authenticated";

grant trigger on table "public"."rooms" to "authenticated";

grant truncate on table "public"."rooms" to "authenticated";

grant update on table "public"."rooms" to "authenticated";

grant delete on table "public"."rooms" to "service_role";

grant insert on table "public"."rooms" to "service_role";

grant references on table "public"."rooms" to "service_role";

grant select on table "public"."rooms" to "service_role";

grant trigger on table "public"."rooms" to "service_role";

grant truncate on table "public"."rooms" to "service_role";

grant update on table "public"."rooms" to "service_role";


  create policy "read messages"
  on "public"."messages"
  as permissive
  for select
  to public
using ((EXISTS ( SELECT 1
   FROM public.room_users
  WHERE ((room_users.room_id = messages.room_id) AND (room_users.user_id = auth.uid())))));



  create policy "send message"
  on "public"."messages"
  as permissive
  for insert
  to public
with check (((auth.uid() = user_id) AND (EXISTS ( SELECT 1
   FROM public.room_users
  WHERE ((room_users.room_id = messages.room_id) AND (room_users.user_id = auth.uid()))))));



  create policy "join room"
  on "public"."room_users"
  as permissive
  for insert
  to public
with check ((auth.uid() = user_id));



  create policy "select room users"
  on "public"."room_users"
  as permissive
  for select
  to public
using ((user_id = auth.uid()));



  create policy "create room"
  on "public"."rooms"
  as permissive
  for insert
  to public
with check ((auth.uid() = created_by));



  create policy "select rooms"
  on "public"."rooms"
  as permissive
  for select
  to public
using ((EXISTS ( SELECT 1
   FROM public.room_users
  WHERE ((room_users.room_id = rooms.id) AND (room_users.user_id = auth.uid())))));



