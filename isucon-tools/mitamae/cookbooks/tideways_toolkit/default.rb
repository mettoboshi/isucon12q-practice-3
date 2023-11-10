# 変数
user_name = "isucon"
user_home = "/home/#{user_name}"
gopath_bin = "$(go env GOPATH)/bin"

# Goの環境がインストールされていることを確認
package 'golang' do
  action :install
end

# tideways/toolkit のインストール
execute "Install tideways toolkit using go" do
  user user_name
  command "go install github.com/tideways/toolkit@latest"
  not_if "test -e #{gopath_bin}/toolkit"
end

# ユーザーのPATHにtideways/toolkitのパスを追加
execute "Add GOPATH/bin to #{user_name}'s PATH" do
  user user_name
  command %Q(echo 'export PATH="$PATH:#{gopath_bin}"' >> #{user_home}/.bashrc)
  not_if %Q(grep -q "#{gopath_bin}" #{user_home}/.bashrc)
end
