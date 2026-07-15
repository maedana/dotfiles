# CLAUDE.md

## TDD
- コードを書くときは原則としてTDDで進めること
- TDDはt-wada流で進めること

## 検索
- grepは使わず必ずrg(ripgrep)を使うこと
- findは使わず必ずfd(fd-find)を使うこと

## 実行方式
- ユーザーから明確な指示がない限り、処理は常にforegroundで実行し、完了を待ってから結果を報告すること
- Bashコマンドをrun_in_background:trueで実行しないこと
- Agent/Task/Workflowなどによる非同期的なバックグラウンド委任も、明確な指示がない限り行わないこと
