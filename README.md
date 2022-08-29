# k8s-echo-two-envs

2 つの Kubernetes クラスタ（production/development）に、自環境名を `echo` する Pod を配置するマニフェスト


# 前提

以下のツールが利用可能であること:
- `make`
- [Terraform](https://www.terraform.io)
- [kubectl](https://kubernetes.io/docs/reference/kubectl/)
- [kind](https://kind.sigs.k8s.io)


# デプロイ手順

本リポジトリでは、 Terraform を利用してローカルテスト環境の構築およびアプリケーションのデプロイの再現性を確保している。
以下の説明では、`${ENV}` を対象の環境に合わせて次のように読み替えること:

- `production`: `prd`
- `development`: `dev`

## ローカルテスト環境の構築

1. `make infra-${ENV}-plan`  # 構築されようとしているローカル kind クラスタの内容を確認
1. `make infra-${ENV}-apply` # ローカル環境に kind クラスタを構築


## ローカルテスト環境へのアプリケーションのデプロイ

1. `make app-${ENV}-plan`  # デプロイされようとしているアプリケーションの内容を確認
1. `make app-${ENV}-apply` # ローカル環境へのアプリケーションのデプロイ

## ローカルテスト環境上にデプロイされたアプリケーションの破棄

1. `make app-${ENV}-destroy`

## ローカルテスト環境の破棄

1. `make infra-${ENV}-destroy`


# サービスの利用

ローカルテスト環境上のアプリケーションへは、Ingress を通じて以下のホストポートから利用できる:

- `production`: 80
- `development`: 8080

ローカルテスト環境の利用例:
```bash
# アプリケーションのデプロイまで完了している状態にて
$ curl localhost # production 環境の利用
production

$ curl localhost:8080 # development 環境の利用
development
```
