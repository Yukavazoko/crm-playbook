# SQL (Segmentações & Risco)

Consultas SQL para **propensão a churn, LTV e scoring**.  
Compatível com **BigQuery/Postgres** (ajuste funções conforme seu stack).

---

## 📌 Propensão a Churn (queda de uso)

**Problema**  
Em B2B SaaS, churn raramente é instantâneo. Ele começa com sinais comportamentais: queda em logins, abandono de features críticas, menor frequência de uso. Se CRM/CS não captura isso cedo, perde a janela de atuação proativa.

**Solução (SQL)**  
Comparar o uso de uma **feature-chave** nas **últimas 4 semanas** com as **4 semanas anteriores**.  
- Considera “risco” quem tinha **uso consistente** (≥10 eventos) e sofreu **queda ≥30%**.  
- Saída gera uma lista acionável para **régua de retenção** e playbook do CSM.

**Blueprint** → [`propensao_churn.sql`](propensao_churn.sql)

**KPIs**  
- % contas em risco  
- Taxa de recuperação (contas que retomam uso após ação)  
- Impacto em **GRR/NRR**  

**Ferramentas**  
- **HubSpot**: enviar eventos de produto (Custom Behavioral Events), criar lista dinâmica de contas em risco e workflow para notificar CSM + ativar régua de retenção.  
- **RD Station**: importar lista via API/CSV ou RD Tracker, marcar tag `risco_churn`, disparar régua de retenção, notificar CS no CRM.  

---

## 📌 LTV por Conta (estimativa)

**Problema**  
Sem estimativa de LTV (Lifetime Value) por conta ou segmento, não é possível:  
- dimensionar CAC viável,  
- priorizar contas de alto valor no CS,  
- nem planejar expansão de forma sustentável.

**Solução (SQL)**  
Modelo simples e ajustável:  
- `ARR_atual`: receita recorrente anual da conta.  
- `horizonte_retencao`: meses médios de retenção por plano/segmento (coorte histórica).  
- `ajuste`: fator de risco vindo da query de churn (reduz expectativa de retenção se a conta sinaliza risco).  

**Blueprint** → [`ltv_por_conta.sql`](ltv_por_conta.sql)

**KPIs**  
- **LTV médio** por plano/segmento  
- **LTV/CAC** (saudável ≥ 3x)  
- **Payback** (meses para recuperar CAC; saudável ≤ 12m em B2B mid-market)  
- **NRR por faixa de LTV** (contas de maior LTV expandem mais?)  

**Ferramentas**  
- **HubSpot**: armazenar ARR, plano, risco em Company Properties; importar LTV estimado via API e usar em listas/reports; workflow de expansão/retention por faixas de LTV.  
- **RD Station**: subir ARR/LTV como campos customizados; segmentar contas de alto LTV para campanhas de upsell; alto LTV + alto risco → acionar CS.  

---

## 📌 Lead Scoring Básico (perfil + engajamento)

**Problema**  
Sem scoring objetivo, SDR recebe volume, não prioridade → mistura curiosos com ICP real, gera no-show e alonga ciclo.

**Solução (SQL)**  
Modelo híbrido:  
- **Perfil (fit)**: setor, porte, cargo, região (peso maior, ~60%).  
- **Engajamento**: visitas a páginas críticas (preços/produto), downloads, replies (peso menor, ~40%).  
- **Boosts**: atalhos para sinais fortes (visitou `/pricing` ≥2x/7d, pediu demo → score = 100).  

**Blueprint** → [`lead_scoring_basico.sql`](lead_scoring_basico.sql)

**KPIs**  
- Conversão Quase MQL → MQL  
- Conversão MQL → SQL + taxa de no-show  
- Tempo médio até MQL  
- Qualidade percebida pelo SDR/CSM  

**Ferramentas**  
- **HubSpot**: Lead Scoring nativo (perfil + eventos); boosts por page views; listas dinâmicas “Quase MQL” e “MQL”; workflows de roteamento.  
- **RD Station**: Lead Scoring nativo (fit vs interesse); tracker para páginas críticas; automações: “quase MQL” → régua de Conversão; “MQL” → SDR.  
