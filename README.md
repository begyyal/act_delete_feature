# 概要

GithubAction。  
アクセストークンとリポジトリ名を受け取り、  
属するfeatureブランチの内でissueクローズ済みのものを全て削除する。  

# 前提

- 本リポジトリをサブモジュールとして追加してプライベートAction化する
- featureブランチの命名規則は feature/[issue_no] で運用する
- **[2021/06/10]トークンはrepo権限を持ったPATを使用すること。**  
ワークフロー内のデフォルトトークンだとpushでコケる。同様のIssueがあったが放置されている模様・・・。  
https://github.community/t/fatal-could-not-read-password-for-https-github-com/119990
