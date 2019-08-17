# Rubi App
入力された文字にルビを付けるiOSアプリケーション

## Environments
`Swift ~> 5.0.1`
`Xcode ~> 10.3`
`Cocoapods ~> 1.7.5`

## APIkey
https://developer.yahoo.co.jp/start/
から取得したアプリケーションキーを ```APIKey.swift``` に書き込んでください。

例:keyがxxxxxxxxxxxxxxxxxxxxxの場合
```
struct APIkey{
    static var key:String{
        return "xxxxxxxxxxxxxxxxxxxxx"
    }
}
```