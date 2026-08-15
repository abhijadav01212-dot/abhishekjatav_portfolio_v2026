import { defineConfig, loadEnv } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '')
  return {
    plugins: [react(), {
      name: 'local-admin-api',
      configureServer(server) {
        server.middlewares.use(async (req, res, next) => {
          if (req.url !== '/api/verify-admin') return next()
          if (req.method !== 'POST') return res.writeHead(405).end()
          let body = ''
          for await (const chunk of req) body += chunk
          const { code } = JSON.parse(body || '{}')
          const authorized = typeof code === 'string' && code === env.ADMIN_ACCESS_CODE
          res.writeHead(authorized ? 200 : 401, { 'Content-Type': 'application/json' })
          res.end(JSON.stringify({ authorized }))
        })
      },
    }],
  }
})
