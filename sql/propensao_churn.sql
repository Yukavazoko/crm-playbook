-- Contas com queda de ≥30% no uso da feature-chave nas últimas 4 semanas
WITH uso AS (
  SELECT
    account_id,
    COUNTIF(event_name='feature_key_used'
      AND event_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 4 WEEK)) AS uso_4w,
    COUNTIF(event_name='feature_key_used'
      AND event_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 8 WEEK)
      AND event_date < DATE_SUB(CURRENT_DATE(), INTERVAL 4 WEEK)) AS uso_prev_4w
  FROM analytics.events
  GROUP BY 1
)
SELECT
  account_id,
  uso_prev_4w,
  uso_4w,
  SAFE_DIVIDE(uso_4w-uso_prev_4w, NULLIF(uso_prev_4w,0)) AS delta
FROM uso
WHERE uso_prev_4w >= 10
  AND SAFE_DIVIDE(uso_4w, NULLIF(uso_prev_4w,0)) <= 0.7
ORDER BY delta ASC;
