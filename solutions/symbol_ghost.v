From iris.algebra Require Import auth numbers.
From iris.base_logic Require Import lib.own.
From iris.proofmode Require Export proofmode.

(** * Ghost theory for the [unsafe_symbol_adt] exercise *)
(** This file defines the ghost resources [counter] and [symbol] using Iris's
generic mechanism for ghost state. These resources satisfy the following laws:

<<
  counter_alloc:      |==> ∃ γ, counter γ n
  counter_exclusive:  counter γ n1 -∗ counter γ n2 -∗ False
  counter_inc:        counter γ n ==∗ counter γ (S n) ∗ symbol γ n
  symbol_obs:         counter γ n -∗ symbol γ s -∗ ⌜(s < n)%nat⌝
>>
*)

Class symbolG Σ := { symbol_inG : inG Σ (authR max_natUR) }.
Local Existing Instance symbol_inG.
Definition symbolΣ : gFunctors := #[GFunctor (authR max_natUR)].

Global Instance subG_symbolΣ {Σ} : subG symbolΣ Σ → symbolG Σ.
Proof. solve_inG. Qed.

Section symbol_ghost.
  Context `{!symbolG Σ}.

  Definition counter (γ : gname) (n : nat) : iProp Σ := own γ (● (MaxNat n)).
  Definition symbol (γ : gname) (n : nat) : iProp Σ := own γ (◯ (MaxNat (S n))).

  Global Instance counter_timeless γ n : Timeless (counter γ n).
  Proof. apply _. Qed.
  Global Instance symbol_timeless γ n : Timeless (symbol γ n).
  Proof. apply _. Qed.

  Global Instance symbol_persistent γ n : Persistent (symbol γ n).
  Proof. apply _. Qed.

  Lemma counter_alloc n : ⊢ |==> ∃ γ, counter γ n.
  Proof.
    iMod (own_alloc (● (MaxNat n) ⋅ ◯ (MaxNat n))) as (γ) "[Hγ Hγf]";
      first by apply auth_both_valid.
    iExists γ. by iFrame.
  Qed.

  Lemma counter_exclusive γ n1 n2 : counter γ n1 -∗ counter γ n2 -∗ False.
  Proof.
    apply bi.entails_wand, bi.wand_intro_r. rewrite -own_op own_valid /=. by iDestruct 1 as %[].
  Qed.

  Lemma counter_inc γ n : counter γ n ==∗ counter γ (S n) ∗ symbol γ n.
  Proof.
    rewrite -own_op.
    apply bi.entails_wand, own_update, auth_update_alloc, max_nat_local_update.
    simpl. lia.
  Qed.

  Lemma symbol_obs γ s n : counter γ n -∗ symbol γ s -∗ ⌜(s < n)%nat⌝.
  Proof.
    iIntros "Hc Hs".
    iCombine "Hc Hs" gives %[?%max_nat_included _]%auth_both_valid_discrete.
    iPureIntro. simpl in *. lia.
  Qed.
End symbol_ghost.

Global Typeclasses Opaque counter symbol.
