SELECT id_from_buildings_from_floors AS Building,id_from_floors AS floor, number AS "room number",rooms.type AS "room type", capacity, facilities.type AS "facilities"
FROM rooms
JOIN facilities 
ON rooms.id = facilities.id_from_rooms
order by Building;
