# 現在の日時を取得
current_time = Time.now.to_s.gsub(/[- :+]/, '')

# カレントディレクトリを取得
current_dir = File.dirname(__FILE__)

# nginx.confの設定
filename = "nginx.conf"
target_directory = "/etc/nginx"
source_directory = "config"

target_path = "#{target_directory}/#{filename}"
source_relative_path = "#{source_directory}/#{filename}"
source_absolute_path = File.expand_path(source_relative_path, current_dir)

# nginx.confのバックアップ
execute "backup #{filename}" do
  command "mv #{target_path} #{target_path}.#{current_time}"
  only_if { File.exist?(target_path) && File.exist?(source_absolute_path) }
  not_if "diff -q #{target_path} #{source_absolute_path}"
end

# nginx.confをコピー（ファイルが存在する場合のみ）
if File.exist?(source_absolute_path)
  remote_file "#{target_path}" do
    owner  "root"
    group  "root"
    source source_absolute_path
    mode   "644"
  end
end

# isucon-php.confの設定
filename = "isuports-php.conf"
target_directory = "/etc/nginx/sites-available"
source_directory = "config/sites-available"

target_path = "#{target_directory}/#{filename}"
source_relative_path = "#{source_directory}/#{filename}"
source_absolute_path = File.expand_path(source_relative_path, current_dir)

# isucon-php.confのバックアップ
execute "backup #{filename}" do
  command "mv #{target_path} #{target_path}.#{current_time}"
  only_if { File.exist?(target_path) && File.exist?(source_absolute_path) }
  not_if "diff -q #{target_path} #{source_absolute_path}"
end

# isucon-php.confをコピー（ファイルが存在する場合のみ）
if File.exist?(source_absolute_path)
  remote_file "#{target_path}" do
    owner  "root"
    group  "root"
    source source_absolute_path
    mode   "644"
  end
end

# nginxの再起動
service "nginx" do
  action :restart
end
