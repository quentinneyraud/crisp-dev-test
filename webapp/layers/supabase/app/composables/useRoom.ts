import type { RealtimePostgresInsertPayload } from '@supabase/supabase-js'
import type { Tables } from '@/types/database.types'

export function useRooms() {
  const client = useSupabaseClient()
  const user = useSupabaseUser()

  const rooms = ref<Tables<'room'>[]>([])
  let channel: ReturnType<typeof client.channel> | null = null

  async function loadRooms() {
    if (!user.value) return

    const { data, error } = await client
      .from('room_users')
      .select('room(id, name, created_at, created_by)')
      .order('room(created_at)', { ascending: false })

    if (error) {
      console.error(error)
      return
    }

    rooms.value = data?.map(r => r.room) ?? []
  }

  function subscribe() {
    if (channel || !user.value) return

    channel = client
      .channel('room-users-realtime')
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'room_users',
        },
        async (payload: RealtimePostgresInsertPayload<Tables<'room_users'>>) => {
          const roomId = payload.new.room_id

          const { data } = await client
            .from('room')
            .select('id, name, created_at, created_by')
            .eq('id', roomId)
            .single()

          if (!data) return

          if (!rooms.value.some(r => r.id === data.id)) {
            rooms.value.unshift(data)
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

  async function createRoom(name: string) {
    if (!user.value) return
    await client.from('room').insert({ name })
  }

  watch(user, async (u) => {
    if (u) {
      await loadRooms()
      subscribe()
    }
    else {
      rooms.value = []
      unsubscribe()
    }
  }, { immediate: true })

  return {
    rooms,
    createRoom,
  }
}
