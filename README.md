# Opt In

## Case: Realtime
##### Problem
Realtime depends on a centralized message broker or server for peer discovery.
##### Solution
- Creator adds default "value/endpoint" to contract. (Which is consumed by application/contract)
- Creator specifies who can add alternatives (token owners)
- Token owners can add alternatives. Limited to 1-N per token owner to avoid spam.
- Token owners can vote/endorse alternatives. This creates an implicit hierarchy of alternatives.
- Token owners can "opt-in" to
    - a) a specific alternative
    - b) the highest ranked alternative
    - c) the highest 2-N ranked alterantives (?)