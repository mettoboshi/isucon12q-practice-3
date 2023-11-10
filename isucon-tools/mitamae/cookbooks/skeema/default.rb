# skeemaに関する情報

# version
VERSION = "1.10.1"

# アーキテクチャ
ARCH = "arm64"
# ARCH = "amd64"

# プラットフォーム
PLATFORM = "linux"

URL = "https://github.com/skeema/skeema/releases/download/v#{VERSION}/skeema_#{VERSION}_#{PLATFORM}_#{ARCH}.tar.gz"

# インストールするディレクトリ
BIN_DIR = File.expand_path('../../../../bin', __FILE__)

# ディレクトリの生成
directory BIN_DIR do
  action :create
end

http_request "/tmp/skeema.tar.gz" do
  url URL
  not_if "test -e /tmp/skeema.tar.gz"
end

execute "Extract Skeema archive" do
  command "tar -xzf /tmp/skeema.tar.gz -C #{BIN_DIR}"
  not_if "test -e #{BIN_DIR}/skeema"
end