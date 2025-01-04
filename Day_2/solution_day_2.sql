/*

Skills used:  
    UNION ALL - needed because UNION alone would remove characters by removing the duplicates
    CTE or subquery
    CHR - ASCII
    string_agg(var,'') - Array aggregation
    SIMILAR - pattern matching

*/
/*

These tables contain pieces of a child's Christmas wish, but they're all mixed up with magical interference from the Northern Lights! We need to:

Filter out the holiday sparkles (noise)
Combine Binky and Blinky's tables
Decode the values back into regular letters
Make sure everything's in the right order!
Valid characters
All lower case letters a - z
All upper case letters A - Z
Space
!
"
'
(
)
,
-
.
:
;
?

*/

SELECT
    STRING_AGG(this_char, '') 
FROM (
    SELECT
        CHR(value) AS this_char
    FROM letters_a
    WHERE CHR(value) SIMILAR TO '[a-zA-Z !\"''(),-.:;?]'
    UNION ALL
    SELECT
        CHR(value) AS this_char
    FROM letters_b
    WHERE CHR(value) SIMILAR TO '[a-zA-Z !\"''(),-.:;?]'
);



/*

Test querys

*/

-- SIMILAR TO operator returns true or false if its pattern matches the given string
-- SIMILAR TO accepts SQL regular expressions
-- https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-SIMILARTO-REGEXP
-- Note: the double quote is escaped with a backslash like this \" but the single quote is escaped with another single quote like this ''

SELECT
    STRING_AGG(this_char, '') 
FROM (
    SELECT
        CHR(value) AS this_char
    FROM letters_b
    WHERE CHR(value) SIMILAR TO '[a-zA-Z !\"''(),-.:;?]'
);

-- Same as below but with UNION ALL. UNION alone does not work as the duplicates are needed.
SELECT
    string_agg(this_char, '')
FROM (
    SELECT
        CHR(value) AS this_char
    FROM letters_a
    UNION ALL
    SELECT
        CHR(value) AS this_char
    FROM letters_b
);

-- Subquery, String aggregation, and CHR
-- The PostgreSQL CHR() function converts an integer ASCII code to a character or a Unicode code point to a UTF8 character.
-- STRING_AGG() aggregation accepts two arguments, the first an expression that can resolve to a character string. The other is the separator for the concatenated strings

SELECT
    STRING_AGG(this_char, '') 
FROM (
    SELECT
        CHR(value) AS this_char
    FROM letters_a
);

SELECT *
FROM letters_a
LIMIT 5;

SELECT *
FROM letters_b
LIMIT 5;