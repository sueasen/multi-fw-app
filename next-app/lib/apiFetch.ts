'use client';

export function getApiUrl(url: string) : string {
  const backendUrl = process.env.NEXT_PUBLIC_BACKEND_URL
  return backendUrl ? new URL(url, backendUrl).toString() : url;
}

export async function apiFetch(
  url: string,
  options: RequestInit = {},
  accessToken?: string
) {
  const headers: Record<string, string> = {
    'Content-Type': 'application/json',
  };
  if (accessToken) headers['Authorization'] = `Bearer ${accessToken}`;

  const response = await fetch(getApiUrl(url), { ...options, headers });
  if ([401, 403].includes(response.status)) {
    localStorage.removeItem('user_session');
    alert('認証されてません。再度ログインしてください。');
    window.location.href = '/';
    throw new Error('Unauthorized');
  }
  if (!response.ok) {
    const error = await response.json();
    throw new Error('APIリクエストに失敗しました. ' + JSON.stringify(error));
  }
  return response.json();
}

export async function apiAuthFetch(url: string, options: RequestInit = {}) {
  const sessionData = JSON.parse(localStorage.getItem('user_session') || '{}');
  const accessToken = sessionData?.access_token || '';
  return apiFetch(url, options, accessToken);
}

export async function errorHandling(
  func: () => Promise<void>,
  setError: (msg: string) => void
) {
  setError('');
  try {
    await func();
  } catch (e: unknown) {
    setError(e instanceof Error ? e.message : 'エラーが発生しました');
    console.error(e);
  }
}
