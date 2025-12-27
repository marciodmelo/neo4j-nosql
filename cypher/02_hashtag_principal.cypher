// Hashtag presente em todos os tweets originais
MATCH (t:Tweet)-[:POSSUI]->(h:Hashtag)
WITH h.tag AS hashtag, COUNT(DISTINCT t) AS qtd_uso
CALL {
  MATCH (x:Tweet)
  RETURN COUNT(x) AS qtd_total
}
WITH hashtag, qtd_uso, qtd_total
WHERE qtd_uso = qtd_total
RETURN hashtag, qtd_uso;
