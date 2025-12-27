// Importação de tweets JSON com APOC
CALL apoc.load.json("file:///tweets_coletados_154.json") YIELD value
UNWIND value.data AS tweet
MERGE (u:User {user_id: tweet.author_id})
MERGE (t:Tweet {id_tuite: tweet.id})
ON CREATE SET
  t.texto = tweet.text,
  t.data_criacao = tweet.created_at,
  t.source = tweet.source,
  t.lang = tweet.lang
FOREACH (hash IN coalesce(tweet.entities.hashtags, []) |
  MERGE (h:Hashtag {tag: apoc.text.replace(apoc.text.clean(hash.tag), "[^a-zA-Z0-9]", "")})
  MERGE (t)-[:POSSUI]->(h)
  MERGE (u)-[:USOU]->(h)
);
