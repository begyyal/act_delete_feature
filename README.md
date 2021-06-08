# 概要

GithubAction。  
アクセストークンとリポジトリ名を受け取り、  
属するfeatureブランチの内でissueクローズ済みのものを全て削除する。  

# 前提

- 本リポジトリをサブモジュールとして追加してプライベートAction化する
- featureブランチの命名規則は feature/[issue_no] で運用する
