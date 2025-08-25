# SQL (Segmentações & Risco)

Consultas SQL para **segmentações, propensão a churn, LTV e scoring**.
Compatível com **BigQuery/Postgres** (ajuste funções conforme seu stack).

---

## 📌 Propensão a Churn (queda de uso)

**Problema**  
Em B2B SaaS, churn raramente é “instantâneo”. Ele começa com sinais comportamentais: queda em logins, abandono de features críticas, menor frequência de uso. Se CRM/CS não captura isso cedo, perde a janela de atuação proativa.

**Solução (SQL)**  
Comparar o uso de uma **feature-chave** nas **últimas 4 semanas** com as **4 semanas anteriores**.  
- Considera “risco” quem tinha **uso consistente** na janela anterior (ex.: ≥10 eventos) e sofreu **queda ≥30%**.  
- Saída gera uma lista acionável para **régua de retenção** e playbook do CSM.

**Blueprint** → [`propensao_churn.sql`](propensao_churn.sql)

**Como interpretar**  
- `uso_prev_4w` = base de comparação (estava usando).  
- `uso_4w` = situação atual.  
- `delta` = (uso_4w − uso_prev_4w) / uso_prev_4w  
  - Ex.: 50 → 30 = **-40%** (risco); 20 → 18 = **-10%** (variação normal).

**KPIs**  
- **% contas sinalizadas** (queda ≥30%)  
- **Taxa de recuperação** (contas que retomam uso após ação)  
- **Impacto em GRR/NRR** (retenção bruta e líquida de receita)

**GRR/NRR — resumo executivo**  
- **GRR (Gross Revenue Retention)**: receita retida **sem** contar upsell.  
  - Ex.: início R$100k; churn R$10k → **GRR 90%**.  
- **NRR (Net Revenue Retention)**: receita retida **+ expansão** (upsell/cross-sell).  
  - Ex.: início R$100k; churn R$10k; upsell R$15k → **NRR 105%**.  
- Leituras: **GRR < 90%** alerta; **NRR > 100%** indica crescimento dentro da base.

**Implementação — HubSpot**  
- **Eventos de Produto (Custom Behavioral Events)**: enviar `feature_key_used` com `account_id`.  
- **Listas dinâmicas/Relatórios**: comparar janelas (mês vs mês anterior).  
- **Workflow**: se queda ≥30% →  
  - Notificar CSM, abrir tarefa;  
  - Entrar em **régua de retenção** (email/WhatsApp);  
  - Se recuperar (uso volta), **retirar da lista**.

**Implementação — RD Station**  
- **Coleta de sinais**:  
  - Via **RD Tracker** (para páginas críticas do app) **ou** integração API para eventos.  
- **Segmentação**: importar/atualizar lista de contas em risco (API/CSV).  
- **Automação**: acionar régua de retenção; marcar tag `risco_churn`; notificar CS via CRM.

**Exemplo de saída (esperado)**
| account_id | uso_prev_4w | uso_4w | delta  |
|------------|-------------|--------|--------|
| A123       | 50          | 30     | -0.40  |
| B456       | 22          | 14     | -0.36  |

---

## 📌 LTV por Conta (estimativa) — *em breve*

**Problema**  
Planejamento de CAC e priorização de CS exigem estimar **valor de vida (LTV)** por conta. Sem isso, investimentos e esforços ficam desbalanceados.

**Solução (SQL)**  
- Estimar **receita média por período** × **horizonte de retenção** (coorte/curva de sobrevivência) por segmento/plan.  
- Ajustar por **descontos** e **probabilidade de churn** (ex.: oriunda da query de risco).

**Entregáveis (planejado)**  
- `ltv_por_conta.sql` (base)  
- Tabelas auxiliares: receitapro mês, status de assinatura, coortes.

**KPIs**  
- LTV médio por segmento/plan; LTV/CAC; payback.

---

## 📌 Lead Scoring Básico (perfil + engajamento) — *em breve*

**Problema**  
Sem um scoring objetivo, o funil mistura curiosos com ICP real, reduz a eficiência de SDR e alonga ciclo.

**Solução (SQL)**  
- **Perfil (fit)**: porte da empresa, setor, região, cargo (peso maior).  
- **Engajamento**: visitas a páginas críticas (preços/produto), downloads, webinars, replies.  
- **Modelo híbrido**: score base + **boosts por eventos críticos** (ex.: visitar `/pricing` 2x em 7d).

**Entregáveis (planejado)**  
- `lead_scoring_basico.sql` (parâmetros comentados)  
- Guia de **calibração** por ICP e por estágio de jornada.

**KPIs**  
- Conversão **quase MQL → MQL**, **MQL → SQL**, tempo até MQL, qualidade percebida por SDR.

---

## Observações Gerais

- Ajuste nomes de tabelas/colunas conforme seu **data warehouse** (ex.: `analytics.events`, `billing.invoices`).  
- Para Postgres, substitua funções específicas do BigQuery (`COUNTIF`, `SAFE_DIVIDE`) por equivalentes:  
  - `COUNT(*) FILTER (WHERE ...)`  
  - `CASE WHEN x=0 THEN NULL ELSE a::numeric/b END`
- Integre a saída das queries ao **CRM** (lista dinâmica, tarefa CSM, automações de retenção/conversão).
