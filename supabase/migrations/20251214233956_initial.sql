
  create table "public"."message" (
    "id" uuid not null default gen_random_uuid(),
    "room_id" uuid not null,
    "created_by" uuid not null default auth.uid(),
    "content" text not null,
    "created_at" timestamp with time zone default now()
      );


alter table "public"."message" enable row level security;


  create table "public"."profile" (
    "id" uuid not null,
    "email" text,
    "created_at" timestamp with time zone default now()
      );


alter table "public"."profile" enable row level security;


  create table "public"."room" (
    "id" uuid not null default gen_random_uuid(),
    "name" text not null,
    "created_by" uuid not null default auth.uid(),
    "created_at" timestamp with time zone default now()
      );


alter table "public"."room" enable row level security;


  create table "public"."room_users" (
    "id" uuid not null default gen_random_uuid(),
    "room_id" uuid not null,
    "user_id" uuid not null default auth.uid(),
    "joined_at" timestamp with time zone default now()
      );


alter table "public"."room_users" enable row level security;

CREATE UNIQUE INDEX message_pkey ON public.message USING btree (id);

CREATE UNIQUE INDEX profile_pkey ON public.profile USING btree (id);

CREATE UNIQUE INDEX room_name_key ON public.room USING btree (name);

CREATE UNIQUE INDEX room_pkey ON public.room USING btree (id);

CREATE UNIQUE INDEX room_users_pkey ON public.room_users USING btree (id);

CREATE UNIQUE INDEX room_users_room_id_user_id_key ON public.room_users USING btree (room_id, user_id);

alter table "public"."message" add constraint "message_pkey" PRIMARY KEY using index "message_pkey";

alter table "public"."profile" add constraint "profile_pkey" PRIMARY KEY using index "profile_pkey";

alter table "public"."room" add constraint "room_pkey" PRIMARY KEY using index "room_pkey";

alter table "public"."room_users" add constraint "room_users_pkey" PRIMARY KEY using index "room_users_pkey";

alter table "public"."message" add constraint "message_created_by_fkey" FOREIGN KEY (created_by) REFERENCES public.profile(id) ON DELETE CASCADE not valid;

alter table "public"."message" validate constraint "message_created_by_fkey";

alter table "public"."message" add constraint "message_room_id_fkey" FOREIGN KEY (room_id) REFERENCES public.room(id) ON DELETE CASCADE not valid;

alter table "public"."message" validate constraint "message_room_id_fkey";

alter table "public"."profile" add constraint "profile_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."profile" validate constraint "profile_id_fkey";

alter table "public"."room" add constraint "room_created_by_fkey" FOREIGN KEY (created_by) REFERENCES public.profile(id) not valid;

alter table "public"."room" validate constraint "room_created_by_fkey";

alter table "public"."room" add constraint "room_name_key" UNIQUE using index "room_name_key";

alter table "public"."room_users" add constraint "room_users_room_id_fkey" FOREIGN KEY (room_id) REFERENCES public.room(id) ON DELETE CASCADE not valid;

alter table "public"."room_users" validate constraint "room_users_room_id_fkey";

alter table "public"."room_users" add constraint "room_users_room_id_user_id_key" UNIQUE using index "room_users_room_id_user_id_key";

alter table "public"."room_users" add constraint "room_users_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.profile(id) ON DELETE CASCADE not valid;

alter table "public"."room_users" validate constraint "room_users_user_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.auto_join_room_after_creation()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  insert into public.room_users(room_id)
  values (new.id);
  return new;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
 SET search_path TO ''
AS $function$
begin
  insert into public.profile (id, email)
  values (new.id, new.email);
  return new;
end;
$function$
;

CREATE OR REPLACE FUNCTION public.is_user_in_room(p_room_id uuid)
 RETURNS boolean
 LANGUAGE sql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  select exists (
    select 1
    from room_users
    where room_id = p_room_id
    and user_id = auth.uid()
  );
$function$
;

CREATE OR REPLACE FUNCTION public.share_room_with(p_user_id uuid)
 RETURNS boolean
 LANGUAGE sql
 SECURITY DEFINER
 SET search_path TO 'public'
AS $function$
  select exists (
    select 1
    from room_users ru1
    join room_users ru2 on ru1.room_id = ru2.room_id
    where ru1.user_id = auth.uid()
    and ru2.user_id = p_user_id
  );
$function$
;

grant delete on table "public"."message" to "anon";

grant insert on table "public"."message" to "anon";

grant references on table "public"."message" to "anon";

grant select on table "public"."message" to "anon";

grant trigger on table "public"."message" to "anon";

grant truncate on table "public"."message" to "anon";

grant update on table "public"."message" to "anon";

grant delete on table "public"."message" to "authenticated";

grant insert on table "public"."message" to "authenticated";

grant references on table "public"."message" to "authenticated";

grant select on table "public"."message" to "authenticated";

grant trigger on table "public"."message" to "authenticated";

grant truncate on table "public"."message" to "authenticated";

grant update on table "public"."message" to "authenticated";

grant delete on table "public"."message" to "service_role";

grant insert on table "public"."message" to "service_role";

grant references on table "public"."message" to "service_role";

grant select on table "public"."message" to "service_role";

grant trigger on table "public"."message" to "service_role";

grant truncate on table "public"."message" to "service_role";

grant update on table "public"."message" to "service_role";

grant delete on table "public"."profile" to "anon";

grant insert on table "public"."profile" to "anon";

grant references on table "public"."profile" to "anon";

grant select on table "public"."profile" to "anon";

grant trigger on table "public"."profile" to "anon";

grant truncate on table "public"."profile" to "anon";

grant update on table "public"."profile" to "anon";

grant delete on table "public"."profile" to "authenticated";

grant insert on table "public"."profile" to "authenticated";

grant references on table "public"."profile" to "authenticated";

grant select on table "public"."profile" to "authenticated";

grant trigger on table "public"."profile" to "authenticated";

grant truncate on table "public"."profile" to "authenticated";

grant update on table "public"."profile" to "authenticated";

grant delete on table "public"."profile" to "service_role";

grant insert on table "public"."profile" to "service_role";

grant references on table "public"."profile" to "service_role";

grant select on table "public"."profile" to "service_role";

grant trigger on table "public"."profile" to "service_role";

grant truncate on table "public"."profile" to "service_role";

grant update on table "public"."profile" to "service_role";

grant delete on table "public"."room" to "anon";

grant insert on table "public"."room" to "anon";

grant references on table "public"."room" to "anon";

grant select on table "public"."room" to "anon";

grant trigger on table "public"."room" to "anon";

grant truncate on table "public"."room" to "anon";

grant update on table "public"."room" to "anon";

grant delete on table "public"."room" to "authenticated";

grant insert on table "public"."room" to "authenticated";

grant references on table "public"."room" to "authenticated";

grant select on table "public"."room" to "authenticated";

grant trigger on table "public"."room" to "authenticated";

grant truncate on table "public"."room" to "authenticated";

grant update on table "public"."room" to "authenticated";

grant delete on table "public"."room" to "service_role";

grant insert on table "public"."room" to "service_role";

grant references on table "public"."room" to "service_role";

grant select on table "public"."room" to "service_role";

grant trigger on table "public"."room" to "service_role";

grant truncate on table "public"."room" to "service_role";

grant update on table "public"."room" to "service_role";

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


  create policy "read messages"
  on "public"."message"
  as permissive
  for select
  to public
using ((EXISTS ( SELECT 1
   FROM public.room_users
  WHERE ((room_users.room_id = message.room_id) AND (room_users.user_id = ( SELECT auth.uid() AS uid))))));



  create policy "send message"
  on "public"."message"
  as permissive
  for insert
  to public
with check (((( SELECT auth.uid() AS uid) = created_by) AND (EXISTS ( SELECT 1
   FROM public.room_users
  WHERE ((room_users.room_id = message.room_id) AND (room_users.user_id = ( SELECT auth.uid() AS uid)))))));



  create policy "insert profile"
  on "public"."profile"
  as permissive
  for insert
  to public
with check ((id = auth.uid()));



  create policy "read profile"
  on "public"."profile"
  as permissive
  for select
  to public
using (public.share_room_with(id));



  create policy "create room"
  on "public"."room"
  as permissive
  for insert
  to public
with check ((( SELECT auth.uid() AS uid) = created_by));



  create policy "select rooms"
  on "public"."room"
  as permissive
  for select
  to public
using ((EXISTS ( SELECT 1
   FROM public.room_users
  WHERE ((room_users.room_id = room.id) AND (room_users.user_id = ( SELECT auth.uid() AS uid))))));



  create policy "join room"
  on "public"."room_users"
  as permissive
  for insert
  to public
with check ((( SELECT auth.uid() AS uid) = user_id));



  create policy "select room users"
  on "public"."room_users"
  as permissive
  for select
  to public
using (public.is_user_in_room(room_id));


CREATE TRIGGER auto_join_room_after_creation AFTER INSERT ON public.room FOR EACH ROW EXECUTE FUNCTION public.auto_join_room_after_creation();

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


