# Case 02 — Reciclagem de MQLs

> **Contexto:** leads que viraram MQL mas não avançaram para SQL (perda por timing, orçamento, fit parcial).

---

## 🎯 Problema
- SDR descartava MQLs que não tinham **timing imediato**, mas ainda eram ICP.  
- Sem reciclagem estruturada, leads esfriavam e nunca mais retornavam.  
- Custo de aquisição elevado → desperdício de investimento.

## 💡 Hipótese
- Uma régua de **reciclagem segmentada** poderia reativar esses leads em 60–90 dias, reduzindo CAC efetivo.  
- Conteúdo de valor + prova de atualização do produto poderia reconquistar interesse.

## 🧪 Experimento (Régua de Reciclagem MQL)
- Critério de entrada: leads **desqualificados** (motivo = timing) OU **sem avanço SQL** após 30 dias.  
- Sequência de 3 emails ao longo de 30 dias:  
  - **D0:** Conteúdo educativo relevante (novo ebook/benchmark)  
  - **D10:** Atualização de produto/feature (diferencial competitivo)  
  - **D25:** Convite para evento/webinar exclusivo  
- Se engajar em qualquer toque → requalificação (score + retorno ao SDR)

**Blueprint técnico:** [`flows/reciclagem_mqls.yaml`](../flows/reciclagem_mqls.yaml)

## 📈 Resultado (mock, 90 dias)
- **Reengagement Rate:** 28% dos leads reciclados  
- **MQL → SQL após reciclagem:** 18% (vs 0% no grupo sem reciclagem)  
- **CAC efetivo:** -15% (ao reaproveitar leads já adquiridos)  
- **Ciclo de vendas médio:** -12% (leads reengajados já conheciam produto)

## 🔍 Insights
- Atualização de produto (D10) foi o gatilho mais forte para retomada (40% dos reengajamentos).  
- Convite para evento (D25) teve menor taxa de clique, mas maior impacto em SQL.  
- Reciclagem foi especialmente eficiente em **Enterprise**, onde timing é mais longo.

## 📚 Aprendizados
- Não descartar MQL = **reciclar** → mais barato que adquirir do zero.  
- Combinar **educativo + prova social + atualização de produto** funciona melhor que só “conteúdo genérico”.  
- Eventos funcionam como “filtro final” para separar curiosos de ICP real.

## 🧭 Próximos passos
- Integrar “motivo de desqualificação” para personalizar régua (timing, budget, fit).  
- Testar cadência mais longa (90d) para Enterprise.  
- SDR outreach manual no último toque para contas estratégicas.

---

### Métricas & Eventos
- Eventos: `asset_downloaded`, `product_update_viewed`, `event_signup`  
- KPIs: Reengagement Rate, MQL→SQL (reciclados), CAC efetivo, ciclo de vendas  
- Ver contrato: [`events_schema/tracking_events.json`](../events_schema/tracking_events.json)

---

> **Nota:** dados anonimizados; métricas mock para ilustrar processo e ganhos.
