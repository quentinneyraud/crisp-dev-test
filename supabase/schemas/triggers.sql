create trigger "auto_join_room_after_creation"
after insert on "room"
for each row
execute function auto_join_room_after_creation();
