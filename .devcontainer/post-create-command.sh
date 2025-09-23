# --- このスクリプトは、コンテナ作成後に一度だけ実行されます ---
echo "--- Running post-create-command.sh ---"

# --- 実行したいコマンドを追記していきます ---
# Python (Flask) の依存関係をインストール
echo "--- Installing Python dependencies... ---"
pip install --user -r flask-app/requirements.txt

# --- スクリプト終了 ---
echo "--- Setup completed successfully! ---"
