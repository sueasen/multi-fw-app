import { NextResponse } from 'next/server';
import { SupabaseAuthService } from '@/lib/supabaseAuthService';

export async function POST(req: Request) {
  const token = req.headers.get('authorization')?.slice(7) ?? '';
  await SupabaseAuthService.logout(token);
  return NextResponse.json({ message: 'Logout successful.' });
}
