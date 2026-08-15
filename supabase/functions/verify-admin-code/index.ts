// Deploy with: supabase functions deploy verify-admin-code
// Set ADMIN_ACCESS_CODE to the private code supplied in the brief.
// The code is deliberately an environment secret, never a frontend constant.
import { serve } from 'https://deno.land/std@0.224.0/http/server.ts'

serve(async (request) => {
  if (request.method !== 'POST') return new Response('Method not allowed', { status: 405 })
  const { code } = await request.json().catch(() => ({}))
  const expected = Deno.env.get('ADMIN_ACCESS_CODE')
  if (!expected || typeof code !== 'string') return Response.json({ authorized: false }, { status: 401 })
  const left = new TextEncoder().encode(code), right = new TextEncoder().encode(expected)
  let difference = left.length ^ right.length
  for (let i = 0; i < Math.max(left.length, right.length); i++) difference |= (left[i] || 0) ^ (right[i] || 0)
  return Response.json({ authorized: difference === 0 }, { status: difference === 0 ? 200 : 401 })
})
