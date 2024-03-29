From exercises Require Export safety.

(** * Parametricity *)
Section parametricity.
  Context `{!heapGS Σ}.

  (** * The polymorphic identity function *)
  Lemma identity_param `{!heapGpreS Σ} e (v : val) σ w es σ' :
    (∀ `{!heapGS Σ}, ⊢ ∅ ⊨ e : ∀ A, A → A) →
    rtc erased_step ([e <_> v]%E, σ) (of_val w :: es, σ') → w = v.
  Proof.
    intros He.
    apply sem_gen_type_safety with (φ := λ u, u = v)=> ?.
    pose (T := SemTy (λ w, ⌜w = v⌝)%I : sem_ty Σ).
    exists T. split.
    { by iIntros (?) "?". }
    iIntros (vs) "!# #Hvs".
    iPoseProof (He with "Hvs") as "He /=".
    wp_apply (wp_wand with "He").
    iIntros (u) "#Hu".
    iSpecialize ("Hu" $! T).
    wp_apply (wp_wand with "Hu"). iIntros (w') "Hw'". by iApply "Hw'".
  Qed.

  (** * Exercise (empty_type_param, easy) *)
  Lemma empty_type_param `{!heapGpreS Σ} e (v : val) σ w es σ' :
    (∀ `{!heapGS Σ}, ⊢ ∅ ⊨ e : ∀ A, A) →
    rtc erased_step ([e <_>]%E, σ) (of_val w :: es, σ') →
    False.
  Proof.
    (* exercise *)
  Admitted.

  (** * Exercise (boolean_param, moderate) *)
  Lemma boolean_param `{!heapGpreS Σ} e (v1 v2 : val) σ w es σ' :
    (∀ `{!heapGS Σ}, ⊢ ∅ ⊨ e : ∀ A, A → A → A) →
    rtc erased_step ([e <_> v1 v2]%E, σ) (of_val w :: es, σ') → w = v1 ∨ w = v2.
  Proof.
    (* exercise *)
  Admitted.

  (** * Exercise (nat_param, hard) *)
  Lemma nat_param `{!heapGpreS Σ} e σ w es σ' :
    (∀ `{!heapGS Σ}, ⊢ ∅ ⊨ e : ∀ A, (A → A) → A → A) →
    rtc erased_step ([e <_> (λ: "n", "n" + #1)%V #0]%E, σ)
      (of_val w :: es, σ') → ∃ n : nat, w = #n.
  Proof.
    (* exercise *)
  Admitted.

  (** * Exercise (strong_nat_param, hard) *)
  Lemma strong_nat_param `{!heapGpreS Σ} e σ w es σ' (vf vz : val) φ :
    (∀ `{!heapGS Σ}, ∃ Φ : sem_ty Σ,
      (⊢ ∅ ⊨ e : ∀ A, (A → A) → A → A) ∧
      (∀ w, ⊢ {{{ Φ w }}} vf w {{{ w', RET w'; Φ w' }}}) ∧
      (⊢ Φ vz) ∧
      (∀ w, Φ w -∗ ⌜φ w⌝)) →
    rtc erased_step ([e <_> vf vz]%E, σ) (of_val w :: es, σ') → φ w.
  Proof.
    (* exercise *)
  Admitted.
End parametricity.
