# Contrato de Eventos (Tracking Schema)

Padrão mínimo para garantir **consistência de dados** entre Marketing, Vendas, Produto e CS.  
Baseado em jornada B2B SaaS, com foco em **ativação, engajamento, retenção e expansão**.

---

## 📌 Problema

Cada time define “evento” de forma diferente:  
- Marketing: cliques e formulários  
- Produto: uso de features  
- CS: tickets, health score  
- Vendas: reuniões, propostas  

Sem contrato claro:  
- Métricas quebram (ativação, TTV, GRR/NRR não batem)  
- Times perdem confiança nos dados  
- Fica impossível integrar CRM ↔ Produto ↔ Marketing

---

## 📌 Solução

Estabelecer um **contrato mínimo de eventos**:  
- `event_name + user_id/account_id + timestamp` (obrigatórios)  
- Propriedades padronizadas (canal, source, consentimento, feature)  
- Representado em JSON Schema (`tracking_events.json`)  
- Categorias alinhadas à jornada B2B SaaS:
  - Aquisição
  - Ativação
  - Onboarding
  - Engajamento
  - Retenção
  - Expansão

---

## 📊 Exemplos de Eventos

| Categoria   | Evento              | Propriedades mínimas            |
|-------------|---------------------|---------------------------------|
| Aquisição   | `lead_captured`     | source, campaign, channel       |
| Ativação    | `signup_completed`  | plan_type, consent              |
| Onboarding  | `integration_done`  | integration_type, ttv_days      |
| Engajamento | `feature_used`      | feature, frequency              |
| Retenção    | `renewal_due`       | contract_value, renewal_date    |
| Expansão    | `upgrade_plan`      | old_plan, new_plan, upsell_val  |

---

## 📈 KPIs Derivados

- **Aquisição**: CPL, CAC, MQL Rate  
- **Ativação**: TTV (time to value), Activation Rate  
- **Engajamento**: WAU/MAU, Feature Adoption  
- **Retenção**: GRR (Gross Revenue Retention), churn de receita  
- **Expansão**: NRR (Net Revenue Retention), upsell rate  

---

## 🔧 Implementação nas Ferramentas

**HubSpot**  
- Usar **Custom Behavioral Events** (Enterprise) para signup, feature usage  
- Integração via API → enviar JSON padronizado  
- Relatórios: funil de produto + CRM + marketing

**RD Station**  
- Tracker nativo → captura cliques/forms  
- API → enviar eventos como `lead_captured`, `signup_completed`, upgrades  
- Guardar como **campos customizados** ou **histórico de lead**  
- Segmentar para campanhas de retenção/expansão

---

## 📂 Arquivo JSON Schema

Ver: [`tracking_events.json`](tracking_events.json)  
