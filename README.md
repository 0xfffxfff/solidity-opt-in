# Opt In

## Case: Realtime
##### Problem
Realtime depends on a centralized message broker or server for peer discovery.
##### Solution
- [x] Creator adds default "value/endpoint" (string) to contract. (Which is consumed by application/contract)
- [x] Creator specifies who can add alternatives (token owners)
- [x] Token owners can add alternatives.
    - [ ] Limited to 1-N per token owner to avoid spam.
- [x] Token owners can endorse alternatives.
    - [ ] This creates an implicit hierarchy of alternatives.
- [x] Token owners can also "undo" endorsments.
- [ ] Token owners can "opt-in" to
    - [x] a specific alternative
    - [ ] the highest ranked alternative
    - [ ] the highest 2-N ranked alterantives (?)