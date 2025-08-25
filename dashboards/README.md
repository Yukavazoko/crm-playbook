# Dashboards & KPIs — definições

KPIs para acompanhar **eficiência de funil**, **retenção** e **saúde financeira (LTV/CAC/Payback)**.

---

## 🎯 Funil (Aquisição → SQL)

| Etapa       | KPI Principal          | Definição/Fórmula                   | Secundários                         |
|-------------|------------------------|--------------------------------------|-------------------------------------|
| Aquisição   | **MQL Rate**           | MQLs ÷ Leads                         | CTR email, CVR LP, CAC por canal    |
| Pré-vendas  | **SQL Rate**           | SQLs ÷ MQLs                          | No-show rate, tempo até 1ª reunião  |
| Ativação    | **Activation Rate**    | % contas com integração ≤14d         | TTV médio, tickets abertos          |
| Engajamento | **WAU/MAU decisores**  | Usuários ativos por papel            | Adoção de features-chave, NPS       |
| Retenção    | **GRR/NRR**            | Receita retida bruta/líquida         | Churn receita, churn logo           |
| Expansão    | **Expansion $**        | Receita de upsell + cross-sell       | % contas com expansão, ARPA         |

---

## 💰 KPIs Financeiros (LTV, CAC, Payback)

**Problema**  
Não basta medir funil; é preciso garantir que o modelo é saudável financeiramente.  
CAC muito alto ou LTV baixo inviabilizam crescimento.  

**Solução**  
Acompanhar 3 KPIs juntos:
- **LTV (Lifetime Value)** = ARR médio × horizonte de retenção (ajustado por risco).  
- **CAC (Customer Acquisition Cost)** = gastos de vendas + marketing ÷ novos clientes adquiridos.  
- **LTV/CAC**: indica se o cliente “paga” o investimento de aquisição.  
- **Payback**: meses para recuperar CAC com receita líquida mensal do cliente.

### 📊 Exemplo por Segmento

| Segmento   | ARR Médio | Retenção Esperada | LTV Est. | CAC | LTV/CAC | Payback (meses) |
|------------|-----------|-------------------|----------|-----|---------|-----------------|
| SMB        | R$ 12k    | 18m               | R$ 18k   | R$ 5k | 3,6x   | 10              |
| Mid-Market | R$ 48k    | 24m               | R$ 96k   | R$ 20k| 4,8x   | 11              |
| Enterprise | R$ 120k   | 36m               | R$ 360k  | R$ 80k| 4,5x   | 12              |

---

## 🚦 Leituras

- **LTV/CAC saudável** ≥ 3x  
- **Payback saudável** ≤ 12 meses (SMB/Mid-market), ≤ 18 meses (Enterprise)  
- **NRR > 100%**: crescimento mesmo sem novas vendas  
- Combinar **propensão a churn + LTV** → priorização de CS:
  - Alto LTV + Alto risco → foco em retenção  
  - Alto LTV + Baixo risco → foco em expansão  
  - Baixo LTV + Alto risco → avaliar custo de retenção  

---

## 🔗 Conexões com SQL

- Query [`ltv_por_conta.sql`](../sql/ltv_por_conta.sql) → gera LTV estimado por conta/segmento.  
- Query [`propensao_churn.sql`](../sql/propensao_churn.sql) → identifica risco para ajustar retenção.  
- Query [`lead_scoring_basico.sql`](../sql/lead_scoring_basico.sql) → melhora priorização no topo do funil.  
