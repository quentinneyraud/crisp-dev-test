create trigger "auto_join_room_after_creation"
after insert on "room"
for each row
execute function auto_join_room_after_creation();

create trigger on_auth_user_created
after insert on auth.users
for each row
execute function handle_new_user();
