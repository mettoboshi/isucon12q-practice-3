# isu-ruby サービスを停止
execute "Stop isu-ruby service" do
  command "systemctl stop isu-ruby"
  only_if "systemctl is-active isu-ruby"
end

# isu-ruby サービスの自動起動を無効化
execute "Disable isu-ruby service" do
  command "systemctl disable isu-ruby"
  only_if "systemctl is-enabled isu-ruby"
end

# isucon.confのシンボリックリンクを削除
file "/etc/nginx/sites-enabled/isucon.conf" do
  action :delete
end

# isucon-php.confのシンボリックリンクを作成
link "/etc/nginx/sites-enabled/isucon-php.conf" do
  to ("/etc/nginx/sites-available/isucon-php.conf")
  action :create
end

# nginxの再起動
service "nginx" do
  action :restart
end

# php8.1-fpm サービスを開始
execute "Start php8.1-fpm service" do
  command "systemctl start php8.1-fpm"
  not_if "systemctl is-active php8.1-fpm"
end

# php8.1-fpm サービスの自動起動を有効化
execute "Enable php8.1-fpm service" do
  command "systemctl enable php8.1-fpm"
  not_if "systemctl is-enabled php8.1-fpm"
end