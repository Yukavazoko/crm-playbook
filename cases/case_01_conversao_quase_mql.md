# Case 01 — Conversão (quase MQL)

> **Contexto:** leads engajados, mas ainda fora do critério de MQL (score 40–59 ou sinais críticos sem conversão).

---

## 🎯 Problema
- Muitos leads **quase prontos**, mas SDR recebia apenas os MQLs formais.  
- Oportunidades se perdiam no “limbo” → leads que visitavam páginas de preço, mas não pediam demo.  
- Resultado: funil com **baixa velocidade de geração de SQL**.

## 💡 Hipótese
- Uma régua curta, com CTA de **diagnóstico rápido** + **prova social** + **ROI**, poderia:  
  - Enriquecer dados (ICP fit)  
  - Estimular pedido de demonstração  
  - Reduzir tempo até MQL

## 🧪 Experimento (Régua de Conversão Quase MQL)
- Critério híbrido de entrada: `score 40–59` **OU** visitou páginas críticas (`/pricing`, `/produto`)  
- Sequência de 3 emails em 7 dias:  
  - **D0:** Diagnóstico (3 perguntas rápidas)  
  - **D2:** Case do segmento + CTA de Demo  
  - **D5:** Comparativo/ROI calculator  
- Boosts de score: resposta completa (+10), demo request (+15)

**Blueprint técnico:** [`flows/conversao_quase_mql.yaml`](../flows/conversao_quase_mql.yaml)

## 📈 Resultado (mock, 45 dias)
- **MQL Conversion Rate:** +27pp (de 33% → **60%**)  
- **Demo Request Rate:** 22% (vs 9% controle)  
- **Tempo até MQL:** -5 dias (média)  
- **SQL Acceptance Rate:** 83% (vs 71% baseline)

## 🔍 Insights
- Diagnóstico (D0) teve 42% de resposta → dados extras de ICP enriqueceram scoring.  
- Case com prova social (D2) foi responsável por 70% das demos.  
- ROI comparativo (D5) ajudou a qualificar leads mais resistentes → menor no-show.

## 📚 Aprendizados
- Critérios híbridos (score + comportamento) são mais fortes que scoring puro.  
- Diagnóstico curto funciona como enriquecimento + qualificação natural.  
- Leads de “quase MQL” podem virar SQL em menos de uma semana.

## 🧭 Próximos passos
- Testar diagnóstico interativo (Typeform/HubSpot Form embutido).  
- Inserir SDR task automática no D3 para leads de segmento Enterprise.  
- A/B do ROI comparativo em formato calculadora vs PDF.

---

### Métricas & Eventos
- Eventos: `form_diagnostico_submitted`, `demo_requested`, `roi_downloaded`  
- KPIs: MQL Conversion Rate, Demo Request Rate, SQL Acceptance Rate  
- Ver contrato: [`events_schema/tracking_events.json`](../events_schema/tracking_events.json)

---

> **Nota:** dados anonimizados; números mock para ilustrar processo e impacto.
