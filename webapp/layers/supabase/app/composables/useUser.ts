export function useUser() {
  const runtimeConfig = useRuntimeConfig()
  const client = useSupabaseClient()
  const user = useSupabaseUser()

  function login(email: string) {
    return client.auth.signInWithOtp({
      email,
      options: {
        emailRedirectTo: `${runtimeConfig.public.APP_URL}/confirm`,
      },
    })
  }

  function logout() {
    return client.auth.signOut()
  }

  return {
    user,
    login,
    logout,
  }
}
