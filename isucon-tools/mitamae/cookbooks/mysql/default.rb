# 現在の日時を取得
current_time = Time.now.to_s.gsub(/[- :+]/, '')

# カレントディレクトリを取得
current_dir = File.dirname(__FILE__)

# 設定ファイルの情報
filename = "mysqld.cnf"
target_directory = "/etc/mysql/mysql.conf.d/"
source_directory = "config/mysql.conf.d/"

target_path = "#{target_directory}/#{filename}"
source_relative_path = "#{source_directory}/#{filename}"
source_absolute_path = File.expand_path(source_relative_path, current_dir)

# 設定ファイルのバックアップ
execute "backup #{filename}" do
  command "mv #{target_path} #{target_path}.#{current_time}"
  only_if { File.exist?(target_path) && File.exist?(source_absolute_path) }
  not_if "diff -q #{target_path} #{source_absolute_path}"
end

# 設定ファイルのコピー
remote_file "#{target_path}" do
  owner  "root"
  group  "root"
  source source_absolute_path
  mode   "644"
  only_if { File.exist?(source_absolute_path) }
  notifies :restart, "service[mysql]"
end

# mysqlの再起動（他のリソースからの通知によってのみ実行される）
service "mysql" do
  action :restart
end