# Abhishek Jatav Portfolio

A responsive React + Vite portfolio with a Supabase-ready shared data layer, document viewers, offer-letter gallery, projects, certificates, and an admin dashboard.

## Run locally

1. Copy `.env.example` to `.env` and add your Supabase project URL and anon key.
2. In Supabase SQL Editor, run `supabase/schema.sql`. Deploy `supabase/functions/verify-admin-code`, then set its `ADMIN_ACCESS_CODE` secret to the private code supplied in the brief. Pair this second factor with Supabase Auth and authenticated-admin write policies before public deployment.
3. Run `npm install`, then `npm run dev`.

The public experience uses verified starter content until Supabase is connected. Once connected, published database content is loaded for every visitor. Upload media to a private/public `portfolio-media` Storage bucket and store its public URL in the relevant record.

## Deployment

Deploy the Vite output to Vercel, Netlify, or Cloudflare Pages. Add the two `VITE_SUPABASE_*` environment variables in the host. Never put the database service role key in the frontend.
