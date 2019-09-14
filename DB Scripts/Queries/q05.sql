SELECT id_from_buildings_from_floors AS Building,id_from_floors AS floor, count(number)AS rooms
FROM rooms
WHERE id_from_buildings_from_floors = 'H'
GROUP BY floor;
