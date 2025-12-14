import type { RealtimePostgresInsertPayload } from '@supabase/supabase-js'
import type { Tables } from '@/types/database.types'

export function useMessages(roomId: Tables<'message'>['id']) {
  const client = useSupabaseClient()
  const user = useSupabaseUser()

  const messages = ref<Tables<'message'>[]>([])
  let channel: ReturnType<typeof client.channel> | null = null

  async function loadLastMessages() {
    if (!roomId || !user.value) return

    const { data, error } = await client
      .from('message')
      .select('id, content, created_by, room_id, created_at')
      .eq('room_id', roomId)
      .order('created_at', { ascending: false })
      .limit(10)

    if (error) {
      console.error(error)
      return
    }

    messages.value = (data ?? []).reverse()
  }

  function subscribe() {
    if (channel) return

    channel = client
      .channel(`messages-${roomId}`)
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'message',
          filter: `room_id=eq.${roomId}`,
        },
        ({ new: message }: RealtimePostgresInsertPayload<Tables<'message'>>) => {
          messages.value.push(message)
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

  async function sendMessage(content: string) {
    if (!roomId || !user.value) return

    await client.from('message').insert({
      room_id: roomId,
      content,
    })
  }

  loadLastMessages()
  subscribe()

  onBeforeUnmount(() => {
    unsubscribe()
  })

  return {
    messages,
    sendMessage,
  }
}
