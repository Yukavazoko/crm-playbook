-- Estimativa operacional de LTV por conta
-- Assumimos três fontes:
-- 1) billing.subscriptions(account_id, arr, plan, segment, is_active)
-- 2) analytics.cohorts(plan, segment, expected_retention_months)  -- média histórica por coorte
-- 3) risk.propensao_churn(account_id, risco_flag, fator_risco)    -- 0..1 (ex.: 0.25 = 25% risco)

WITH base AS (
  SELECT
    s.account_id,
    s.arr,                                      -- ARR atual (R$/ano)
    s.plan,
    s.segment,
    COALESCE(c.expected_retention_months, 18) AS exp_retention_mo,  -- fallback 18m
    COALESCE(r.fator_risco, 0.0) AS fator_risco                    -- 0 se não houver risco
  FROM billing.subscriptions s
  LEFT JOIN analytics.cohorts c
    ON c.plan = s.plan AND c.segment = s.segment
  LEFT JOIN risk.propensao_churn r
    ON r.account_id = s.account_id
  WHERE s.is_active = TRUE
),
ajustes AS (
  SELECT
    account_id,
    arr,
    plan,
    segment,
    exp_retention_mo,
    fator_risco,
    -- ajuste simples: reduz expectativa de retenção conforme risco atual
    GREATEST(6, ROUND(exp_retention_mo * (1 - fator_risco), 0)) AS exp_retention_mo_ajust  -- mínimo 6 meses
  FROM base
)
SELECT
  account_id,
  plan,
  segment,
  arr,
  exp_retention_mo AS expectativa_retencao_meses_base,
  exp_retention_mo_ajust AS expectativa_retencao_meses_ajustada,
  ROUND(arr * (exp_retention_mo_ajust / 12.0), 2) AS ltv_est -- ARR * anos ajustados
FROM ajustes
ORDER BY ltv_est DESC;

-- Postgres:
-- - Trocar ROUND(x, 2) por ROUND(x::numeric, 2)
-- - Sem COUNTIF: aqui não usamos; se usar, adapte com FILTER.
