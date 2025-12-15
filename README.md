# Supa chat

> [Live demo](https://crisp-dev-test.netlify.app/) 

## Installation

1. Prerequisites

- Node
- Docker
- Supabase CLI (optional) [docs](https://supabase.com/docs/guides/local-development/cli/getting-started)

2. Clone & installation

```bash
git clone ...

cd crisp-dev-test

pnpm i
```

3. Supabase

```bash
npx supabase start
```

4. Webapp

Rename `.env.example` file to `.env` and update `SUPABASE_URL` & `SUPABASE_KEY` with infos from the previous command.

Then

```
pnpm run dev
```

5. Usage

- Webapp : `http:localhost:3000`
- Supabase dashboard : `http://127.0.0.1:54323`
- Mailpit : `http://127.0.0.1:54324` (catch all OTP email sent from Supabase)


## Resources

- [Supabase : Declarative database schemas](https://supabase.com/docs/guides/local-development/declarative-database-schemas)
- [Nuxt Supabase module](https://supabase.nuxtjs.org/)
