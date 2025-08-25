-- Lead Scoring Básico (perfil + engajamento + boosts por eventos críticos)
-- Assumimos:
-- - crm.leads (lead_id, account_id, role, industry, company_size, region)
-- - web.pageviews (lead_id, page, event_date)
-- - mkt.assets (lead_id, asset_type, event_date) -- downloads, webinar_signup
-- - comm.emails (lead_id, action, event_date)    -- open/click/reply
-- - sales.demo_requests (lead_id, requested_at)

WITH perfil AS (
  SELECT
    l.lead_id,
    (CASE WHEN l.industry IN ('SaaS','Fintech','EduTech') THEN 15 ELSE 0 END) +
    (CASE WHEN l.company_size BETWEEN 50 AND 500 THEN 15 ELSE 0 END) +
    (CASE WHEN l.role IN ('CEO','Director','Head','Manager') THEN 20 ELSE 0 END) +
    (CASE WHEN l.region IN ('BR','LATAM') THEN 10 ELSE 0 END) AS score_fit
  FROM crm.leads l
),
engajamento_raw AS (
  SELECT
    pv.lead_id,
    SUM(CASE WHEN pv.page ILIKE '%/pricing%' THEN 8 ELSE 0 END) +
    SUM(CASE WHEN pv.page ILIKE '%/produto%' THEN 6 ELSE 0 END) AS score_pages,
    SUM(CASE WHEN a.asset_type IN ('ebook_funnel_meio','comparativo','roi_calc') THEN 6 ELSE 0 END) AS score_assets,
    SUM(CASE WHEN e.action = 'reply' THEN 10 ELSE 0 END) AS score_reply
  FROM crm.leads l
  LEFT JOIN web.pageviews pv ON pv.lead_id = l.lead_id
  LEFT JOIN mkt.assets a ON a.lead_id = l.lead_id
  LEFT JOIN comm.emails e ON e.lead_id = l.lead_id
  GROUP BY 1
),
boosts AS (
  SELECT
    pv.lead_id,
    -- boost se visitou pricing 2+ vezes em 7 dias
    CASE WHEN COUNT(*) FILTER (
           WHERE pv.page ILIKE '%/pricing%'
             AND pv.event_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 7 DAY)
         ) >= 2 THEN 15 ELSE 0 END AS boost_pricing_2x,
    -- atalho: se pediu demo, vira 100
    CASE WHEN EXISTS (
      SELECT 1 FROM sales.demo_requests d
      WHERE d.lead_id = pv.lead_id
    ) THEN 100 ELSE 0 END AS shortcut_demo
  FROM web.pageviews pv
  GROUP BY 1
),
score_final AS (
  SELECT
    p.lead_id,
    p.score_fit,
    COALESCE(e.score_pages,0) + COALESCE(e.score_assets,0) + COALESCE(e.score_reply,0) AS score_engagement,
    b.boost_pricing_2x,
    b.shortcut_demo,
    CASE
      WHEN b.shortcut_demo >= 100 THEN 100
      ELSE LEAST(100, p.score_fit + (COALESCE(e.score_pages,0)+COALESCE(e.score_assets,0)+COALESCE(e.score_reply,0)) + b.boost_pricing_2x)
    END AS lead_score
  FROM perfil p
  LEFT JOIN engajamento_raw e ON e.lead_id = p.lead_id
  LEFT JOIN boosts b ON b.lead_id = p.lead_id
)
SELECT
  lead_id,
  score_fit,
  score_engagement,
  boost_pricing_2x,
  shortcut_demo,
  lead_score,
  CASE
    WHEN lead_score >= 60 THEN 'MQL'
    WHEN lead_score BETWEEN 40 AND 59 THEN 'QUASE_MQL'
    ELSE 'LEAD'
  END AS stage_sugerido
FROM score_final
ORDER BY lead_score DESC;

-- BigQuery:
-- - ILIKE pode ser substituído por LOWER(page) LIKE '%/pricing%'
-- Postgres:
-- - DATE_SUB(...) -> CURRENT_DATE - INTERVAL '7 day'
-- - COUNT(*) FILTER (WHERE ...) já é nativo
