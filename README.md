# k8s-echo-two-envs

2 つの Kubernetes クラスタ（production/development）に、自環境名を `echo` する Pod を配置するマニフェスト


## 前提

- `make` を利用可能
- `kubectl` を利用可能
- `kubectl` 経由で操作可能な Kubernetes クラスタが 2 つ立っている（以下では、それぞれを「`production` クラスタ」「`development` クラスタ」と呼ぶ）
  - 各クラスタは Ingress を利用可能になっている
  - 各クラスタを操作するためのコンテキスト名には、それぞれの環境名（`production` または `development`）が含まれる

上記の前提を満たしていない場合には末尾の「**環境構築**」を参照のこと。


## デプロイ手順

### `production`

1. `current-context` が `production` クラスタを向いていることを確認
2. リポジトリルートにて `make deploy-prd` を実行

### `development`

1. `current-context` が `development` クラスタを向いていることを確認
2. リポジトリルートにて `make deploy-dev` を実行


## 環境構築

`make` はごく一般的なコマンドであるため、この環境構築方法は割愛する。


### `kubectl`

参考リンク: https://kubernetes.io/docs/tasks/tools/#kubectl


### クラスタの設定（`kind` 利用）

本リポジトリを利用した開発には任意の Kubernetes 環境を利用して構わないが、ここでは [`kind`](https://kind.sigs.k8s.io) を利用する場合の環境構築手順を記す。


#### `kind` のインストール

[公式ドキュメント](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) を参考にして済ませておく。


#### Ingress を利用可能にするための準備

クラスタ内にデプロイしたアプリケーションをクラスタの外から利用するためには、Ingress リソースを作る必要がある。
しかし、`kind` などの非マネージドな Kubernetes 環境では、Ingress コントローラの設定を済ませない限り、Ingress を利用できない。
[公式ドキュメント](https://kind.sigs.k8s.io/docs/user/ingress/)によると、`kind` 環境において利用可能な Ingress コントローラには複数の選択肢があるが、ここでは [Ingress NGINX](https://kind.sigs.k8s.io/docs/user/ingress/#ingress-nginx)を利用する方法を記す。


##### クラスタの構築

Ingress 開通後のローカルマシン側ポートが重複しないように配慮して、`production` クラスタと `development` クラスタを立てる。
`.setup/` 以下にある各クラスタ用の設定ファイルを指定して、下記のようにクラスタを起動する:
```bash
kind create cluster --name production --config .setup/kind-prd.yaml  # production クラスタを起動（ローカルマシンのポート 80 を利用）
kind create cluster --name development --config .setup/kind-dev.yaml  # development クラスタを起動（ローカルマシンのポート 8080 を利用）
```
ローカルマシン側でポートが重複した場合には、`.setup/kind-{ENV}.config` の `hostPort` の値を適当なポート番号に書き換えて再実行すること。


クラスタの準備が整ったことを `kubectl get nodes` などで確認できたら、Ingress コントローラをデプロイする（それぞれのクラスタで必要）:
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

Ingress コントローラの準備が整ったことが確認できれば設定完了:
```bash
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
```


#### コンテキスト名の設定

本リポジトリでは、`make` を利用してデプロイ手順を簡略化している。
デプロイ用の `make` ターゲットでは、意図していないクラスタへのデプロイを避ける目的で `current context` を読み取っているため、`production` クラスタと `development` クラスタを操作するコンテキストには、それぞれの環境名を設定しておく必要がある。
`kind` を利用した上記の手順に従った場合には、`--name {ENVNAME}` の指定によって、コンテキスト名は既に `kind-{ENVNAME}` の形になっている。
`kind` を利用していない場合には `kubectl config set-context` を利用して、それぞれのクラスタを向いたコンテキストを作成すること。
