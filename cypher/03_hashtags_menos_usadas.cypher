// Hashtags menos usadas
MATCH (t:Tweet)-[:POSSUI]->(h:Hashtag)
WITH h.tag AS hashtag, COUNT(t) AS qtd
ORDER BY qtd ASC
RETURN hashtag, qtd
LIMIT 3;
