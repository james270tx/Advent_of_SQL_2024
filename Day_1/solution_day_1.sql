/*

The challenge: Create a report that helps Santa and the elves understand:

    Each child's primary and backup gift choices
    Their color preferences
    How complex each gift is to make
    Which workshop department should handle the creation

*/
/*

Create a report showing what gifts children want, with difficulty ratings and categorization as such:

    name,primary_wish,backup_wish,favorite_color,color_count,gift_complexity,workshop_assignment

    The primary wish will be the first choice
    The secondary wish will be the second choice
    You can presume the favorite color is the first color in the wish list

Gift complexity can be mapped from the toy difficulty to make. Assume the following:
    Simple Gift = 1
    Moderate Gift = 2
    Complex Gift >= 3

We assign the workshop based on the primary wish's toy category. Assume the following:
    outdoor = Outside Workshop
    educational = Learning Workshop
    all other types = General Workshop

Order the list by name in ascending order.

Your answer should limit its return to only 5 rows

*/
/*

 name  | primary_wish | backup_wish | favorite_color | color_count | gift_complexity | workshop_assignment
  ----------------------------------------------------------------------------------------------------------
  Tommy | bike         | blocks      | red            | 2           | Complex Gift    | Outside Workshop
  Sally | doll         | books       | pink           | 2           | Moderate Gift   | General Workshop
  Bobby | blocks       | bike        | green          | 1           | Simple Gift    | Learning Workshop

*/

SELECT
    name,
    primary_wish,
    secondary_wish,
    favourite_color,
    color_count,
    CASE toy_catalogue.difficulty_to_make
        WHEN 1 THEN 'Simple Gift'
        WHEN 2 THEN 'Moderate Gift'
        ELSE 'Complex Gift'
    END AS gift_complexity,
    CASE toy_catalogue.category
        WHEN 'outdoor' THEN 'Outside Workshop'
        WHEN 'educational' THEN 'Learning Workshop'
        ELSE 'General Workshop'
    END AS workshop_assignment
FROM (
    SELECT 
        children.name AS name,
        wishes->>'first_choice' as primary_wish,
        wishes->>'second_choice' as secondary_wish,
        wishes#>>'{colors,0}' as favourite_color,
        json_array_length(wishes::json->'colors') as color_count
    FROM children
    INNER JOIN wish_lists ON children.child_id = wish_lists.child_id
) AS christmas_lists 
INNER JOIN toy_catalogue ON christmas_lists.primary_wish = toy_catalogue.toy_name
ORDER BY name ASC
LIMIT 5;

/*

Test Querys

*/


SELECT 
    children.name,
    wishes->>'first_choice' as primary_wish,
    wishes->>'second_choice' as secondary_wish,
    wishes#>>'{colors,0}' as favourite_color,
    json_array_length(wishes::json->'colors') as color_count
FROM children
INNER JOIN wish_lists ON children.child_id = wish_lists.child_id;


SELECT child_id,
      wishes->>'first_choice' as primary_wish,
      wishes#>>'{colors,0}' as favourite_color,
      json_array_length(wishes::json->'colors') as color_count
FROM wish_lists;

SELECT *
FROM children
LIMIT 10;

SELECT *
FROM wish_lists
LIMIT 10;

SELECT *
FROM toy_catalogue
LIMIT 10;