This is a [Next.js](https://nextjs.org) project bootstrapped with [`create-next-app`](https://nextjs.org/docs/app/api-reference/cli/create-next-app).

## Getting Started

First, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `app/page.tsx`. The page auto-updates as you edit the file.

## Testing

Repo-wide follow-up (CI, p15 docs, p11/p13, p18): [`docs/CONTINUATION_PLAN.md`](../docs/CONTINUATION_PLAN.md).

- **Unit / component:** `npm run test`
- **E2E (Playwright):** needs a **production build** first (`.next`). Then either:
  - **One command:** `npm run test:e2e:full` — builds, then Playwright starts `next start` and runs tests (no separate terminal).
  - **Already built:** `npm run test:e2e` — skips the build step. If something already serves `http://127.0.0.1:3001`, Playwright **reuses** it; otherwise it starts `next start` on that port.
  - **Port 3001 busy / `EADDRINUSE`:** stop the other process, or run e.g. `PLAYWRIGHT_PORT=3002 PLAYWRIGHT_BASE_URL=http://127.0.0.1:3002 npm run test:e2e` (PowerShell: `$env:PLAYWRIGHT_PORT='3002'; $env:PLAYWRIGHT_BASE_URL='http://127.0.0.1:3002'; npm run test:e2e`).

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js) - your feedback and contributions are welcome!

## Deploy on Vercel

The easiest way to deploy your Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/app/building-your-application/deploying) for more details.
