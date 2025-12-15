import type { RealtimePostgresChangesPayload } from '@supabase/supabase-js'
import type { Tables } from '@/types/database.types'

export function useRoom() {
  const client = useSupabaseClient()
  const user = useSupabaseUser()

  const userRooms = useState<Tables<'room'>[]>('userRooms', () => [])
  const channel = useState<ReturnType<typeof client.channel> | null>('userRoomsChannel', () => null)

  async function loadRooms() {
    if (!user.value) return

    const { data, error } = await client
      .from('room_users')
      .select('room(id, name, created_at, created_by)')
      .eq('user_id', user.value.sub)
      .order('room(created_at)', { ascending: false })

    if (error) {
      console.error(error)
    }

    userRooms.value = data?.map(a => a.room) ?? []
  }

  function subscribe() {
    if (channel.value || !user.value) return

    channel.value = client
      .channel('room-users-realtime')
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'room_users',
        },
        async (payload: RealtimePostgresChangesPayload<Tables<'room_users'>>) => {
          if (payload.eventType === 'INSERT') {
            const roomId = payload.new.room_id

            const { data } = await client
              .from('room')
              .select('id, name, created_at, created_by')
              .eq('id', roomId)
              .single()

            if (!data) return

            if (!userRooms.value.some(a => a.id === data.id)) {
              userRooms.value.unshift(data)
            }
          }
        },
      )
      .subscribe()
  }

  function unsubscribe() {
    if (channel.value) {
      client.removeChannel(channel.value)
      channel.value = null
    }
  }

  async function createRoom(name: string) {
    if (!user.value) return
    await client.from('room').insert({ name })
  }

  async function joinRoom(name: string) {
    if (!user.value) return

    const { data: room, error: roomError } = await client
      .from('room')
      .select('id')
      .eq('name', name)
      .maybeSingle()

    if (!room || roomError) return

    const { error } = await client
      .from('room_users')
      .insert({
        room_id: room.id,
      })

    if (error) {
      console.error(error)
      throw error
    }
  }

  return {
    loadRooms,
    subscribe,
    unsubscribe,
    userRooms,
    createRoom,
    joinRoom,
  }
}
