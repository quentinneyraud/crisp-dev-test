import type { RealtimePostgresChangesPayload } from '@supabase/supabase-js'
import type { Tables } from '../../../../app/types/database.types'

export function useRoomUsers(roomId: string) {
  const client = useSupabaseClient()
  const user = useSupabaseUser()

  const users = ref<Tables<'profile'>[]>([])
  let channel: ReturnType<typeof client.channel> | null = null

  async function loadUsers() {
    if (!roomId || !user.value) return

    const { data, error } = await client
      .from('room_users')
      .select(`
          profile(*)
      `)
      .eq('room_id', roomId)
      .order('joined_at')

    if (error) {
      console.error(error)
      return
    }

    users.value = data.map(v => v.profile) ?? []
  }

  function subscribe() {
    if (channel) return

    channel = client
      .channel(`room-users-${roomId}`)
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'room_users',
          filter: `room_id=eq.${roomId}`,
        },
        (payload: RealtimePostgresChangesPayload<Tables<'room_users'>>) => {
          if (payload.eventType === 'INSERT') {
            loadUsers()
          }

          if (payload.eventType === 'DELETE') {
            users.value = users.value.filter(
              u => u.id !== payload.old.user_id,
            )
          }
        },
      )
      .subscribe()
  }

  function unsubscribe() {
    if (channel) {
      client.removeChannel(channel)
      channel = null
    }
  }

  loadUsers()
  subscribe()

  onBeforeUnmount(unsubscribe)

  return {
    users,
  }
}
