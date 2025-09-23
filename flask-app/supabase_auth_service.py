from config import Config
import requests
from typing import Dict, Any, Tuple

class SupabaseAuthService:
    def __init__(self):
        self.url = Config.SUPABASE_URL
        self.anon_key = Config.SUPABASE_ANON_KEY

    # APIリクエスト処理
    def api_request(self, method: str, path: str, data: Dict[str, Any] = None, access_token: str = None) -> Tuple[Dict[str, Any], int]:
        headers = {"apikey": self.anon_key, "Content-Type": "application/json"}
        if access_token:
            headers["Authorization"] = f"Bearer {access_token}"
        url = f"{self.url}{path}"
        try:
            if method.upper() == "POST":
                response = requests.post(url, headers=headers, json=data)
            else:
                response = requests.get(url, headers=headers)
            response.raise_for_status()
            return response.json(), response.status_code
        except requests.exceptions.HTTPError as e:
            return e.response.json(), e.response.status_code
        except requests.exceptions.RequestException as e:
            return {"error": f"Network error: {str(e)}"}, 500

    # ログイン(メール/パスワード)
    def signin_with_password(self, email: str, password: str) -> Tuple[Dict[str, Any], int]:
        data = {"email": email, "password": password}
        return self.api_request("POST", "/auth/v1/token?grant_type=password", data=data)

    # サインアップ(メール/パスワード)
    def signup(self, email: str, password: str, redirect_to: str) -> Tuple[Dict[str, Any], int]:
        data = {"email": email, "password": password, "options": {"email_redirect_to": redirect_to}}
        return self.api_request("POST", "/auth/v1/signup", data=data)

    # GitHub認証用URL取得
    def get_github_signin_url(self, redirect_to: str) -> str:
        return f"{self.url}/auth/v1/authorize?provider=github&redirect_to={redirect_to}&scopes=user:email"

    # ユーザ情報取得
    def get_user_by_access_token(self, access_token: str) -> Tuple[Dict[str, Any], int]:
        return self.api_request("GET", "/auth/v1/user", access_token=access_token)
    
    # サインアウト
    def signout(self, access_token: str) -> Tuple[Dict[str, Any], int]:
        return self.api_request("POST", "/auth/v1/logout", access_token=access_token)
