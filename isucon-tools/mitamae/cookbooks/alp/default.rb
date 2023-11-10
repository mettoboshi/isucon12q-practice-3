# alpのバージョンとアーキテクチャを指定
VERSION = "1.0.14"
ARCH = "linux_amd64"
# ARCH = "linux_arm64"

BIN_DIR = File.expand_path('../../../../bin', __FILE__)

# alpのバイナリをダウンロード
execute "Download alp" do
  command "wget https://github.com/tkuchiki/alp/releases/download/v#{VERSION}/alp_#{ARCH}.zip -O /tmp/alp_#{ARCH}.zip"
  not_if "test -e /tmp/alp_#{ARCH}.zip"
end

# unzipのインストール
package 'unzip' do
  action :install
end

# ダウンロードしたZIPファイルを解凍
execute "Unzip alp binary" do
  command "unzip /tmp/alp_#{ARCH}.zip -d /tmp"
  not_if "test -e /tmp/alp"
end

# alpバイナリを/usr/local/binに移動して実行権限を付与
execute "Install alp" do
  command "mv /tmp/alp #{BIN_DIR}/alp && chmod +x #{BIN_DIR}/alp"
  not_if "test -e #{BIN_DIR}/alp"
end
