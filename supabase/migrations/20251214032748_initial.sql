
  create table "public"."message" (
    "id" uuid not null default gen_random_uuid(),
    "room_id" uuid not null,
    "created_by" uuid not null default auth.uid(),
    "content" text not null,
    "created_at" timestamp with time zone default now()
      );


alter table "public"."message" enable row level security;


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

CREATE UNIQUE INDEX room_name_key ON public.room USING btree (name);

CREATE UNIQUE INDEX room_pkey ON public.room USING btree (id);

CREATE UNIQUE INDEX room_users_pkey ON public.room_users USING btree (id);

CREATE UNIQUE INDEX room_users_room_id_user_id_key ON public.room_users USING btree (room_id, user_id);

alter table "public"."message" add constraint "message_pkey" PRIMARY KEY using index "message_pkey";

alter table "public"."room" add constraint "room_pkey" PRIMARY KEY using index "room_pkey";

alter table "public"."room_users" add constraint "room_users_pkey" PRIMARY KEY using index "room_users_pkey";

alter table "public"."message" add constraint "message_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."message" validate constraint "message_created_by_fkey";

alter table "public"."message" add constraint "message_room_id_fkey" FOREIGN KEY (room_id) REFERENCES public.room(id) ON DELETE CASCADE not valid;

alter table "public"."message" validate constraint "message_room_id_fkey";

alter table "public"."room" add constraint "room_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."room" validate constraint "room_created_by_fkey";

alter table "public"."room" add constraint "room_name_key" UNIQUE using index "room_name_key";

alter table "public"."room_users" add constraint "room_users_room_id_fkey" FOREIGN KEY (room_id) REFERENCES public.room(id) ON DELETE CASCADE not valid;

alter table "public"."room_users" validate constraint "room_users_room_id_fkey";

alter table "public"."room_users" add constraint "room_users_room_id_user_id_key" UNIQUE using index "room_users_room_id_user_id_key";

alter table "public"."room_users" add constraint "room_users_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

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
using ((user_id = ( SELECT auth.uid() AS uid)));


CREATE TRIGGER auto_join_room_after_creation AFTER INSERT ON public.room FOR EACH ROW EXECUTE FUNCTION public.auto_join_room_after_creation();


